#!/usr/bin/env bash
set -euo pipefail

# Set input, reset output, set trap
target=${1:-}
output=${2:-badurls.txt}
concurrency=${3:-60}
[[ -f "$target" ]] || { echo "usage: $0 input.txt [output] [concurrency]"; exit 1; }
: > "$output"
trap 'rm -rf "${tmpdir_main:-}" "${tmpdir_final:-}" "${list_main:-}"; kill 0 2>/dev/null || true' EXIT

# Produce NUL-separated cleaned lines (strip CR, trim, drop blanks/comments)
_listparser() {
  awk '{ sub(/\r$/,""); sub(/^[ \t]+/,""); sub(/[ \t]+$/,""); 
    if($0==""||$0~/^#/) next; 
    printf "%s\0",$0 }' "$@" ;
}

# First Pass
tmpdir_main=$(mktemp -d)

_listparser "$target" | xargs -0 -P "$concurrency" -I{} bash -c '
url="$1"
mkdir -p "'"$tmpdir_main"'"
has_record=0

doh=$(curl -s --connect-timeout 5 --max-time 6 --retry-delay 0.5 --retry 2 -G --data-urlencode "name=$url" \
 -H "Accept: application/dns-json" "https://cloudflare-dns.com/dns-query" 2>/dev/null || true)
if [[ -n $doh && $doh =~ \"(Answer|Authority)\" ]]; then
  has_record=1
fi

if [[ $has_record -eq 1 ]]; then
  printf "%s -> EXISTS\n" "$url"
else
  printf "%s -> NO_DNS_RECORD\n" "$url"
  tmpf="$(mktemp "'"$tmpdir_main"'/worker.XXXXXX")"
  printf "%s\n" "$url" >> "$tmpf"
fi
sleep 0.0001
' _ "{}"

# Merge any worker tmp files for initial badurls list
if compgen -G "$tmpdir_main"/worker.*; then
  list_main=$(mktemp)
  cat "$tmpdir_main"/worker.* | sort -u >> "$list_main"
fi

# Second Pass
tmpdir_final=$(mktemp -d)

_listparser "$list_main" | xargs -0 -P "$concurrency" -I{} bash -c '
url="$1"
mkdir -p "'"$tmpdir_final"'"
has_record=0

for t in A AAAA CNAME MX NS TXT; do
  doh=$(curl -s --connect-timeout 5 --max-time 6 --retry-delay 0.5 --retry 2 -G --data-urlencode "name=$url" \
   -G --data "type=${t}" -H "Accept: application/dns-json" "https://cloudflare-dns.com/dns-query" 2>/dev/null || true)
  if [[ -n $doh && $doh =~ \"(Answer|Authority)\" ]]; then
    has_record=1; break
  fi
  sleep 0.001
done

if [[ $has_record -eq 1 ]]; then
  printf "%s -> EXISTS\n" "$url"
else
  printf "%s -> NO_DNS_RECORD\n" "$url"
  tmpf="$(mktemp "'"$tmpdir_final"'/worker.XXXXXX")"
  printf "%s\n" "$url" >> "$tmpf"
fi
sleep 0.0001
' _ "{}"

# Merge any worker tmp files for final badurls list
if compgen -G "$tmpdir_final"/worker.*; then
  cat "$tmpdir_final"/worker.* | sort -u >> "$output"
fi
