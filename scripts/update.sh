#!/usr/bin/env bash

# Generates all the blocklists from the content of the `sources` folder.
# Usage:
# ./scripts/update.sh

# Normalize sources

## Normalize domains: lowercases, remove leading spaces, protocol (`x://`), `www.` subdomains, path ( `/` and after), leave only one space before inline comment (`#`). Keeps comments intact
# (same code in import.sh)
find ./sources/domains -type f -iname "*.txt" -exec sed -ri 'h; s/[^#]*//1; x; s/#.*//; s/.*/\L&/; s/^[[:space:]]*//i; s/^.*:\/\///i; s/^[.*]*//i; s/^ww[w[:digit:]]\.//i; s/\/[^[:space:]]*//i; s/[[:space:]].*$/ /i; G; s/(.*)\n/\1/' {} \;
## Normalize URLs: remove leading spaces, protocol (`*://*`), `www.` subdomains, last `/`, leave only one space before inline comment (`#`). Keeps comments intact
# add remove last /
find ./sources/urls -type f -iname "*.txt" -exec sed -ri 'h; s/[^#]*//1; x; s/#.*//; s/^[[:space:]]*//i; s/^.*:\/\///i; s/^[.*]*//i; s/^ww[w[:digit:]]\.//i; s/[[:space:]].*$/ /i; G; s/(.*)\n/\1/' {} \;
## Normalize TLDs: lowercases, remove leading spaces and `.`, path ( `/` and after), leave only one space before inline comment (`#`). Keeps comments intact
find ./sources/tlds -type f -iname "*.txt" -exec sed -ri 'h; s/[^#]*//1; x; s/#.*//; s/.*/\L&/; s/^[[:space:]]*//i; s/^[.*]*//i;  s/\/[^[:space:]]*//i; s/[[:space:]].*$/ /i; G; s/(.*)\n/\1/' {} \;

### Remove duplicate lines from each source file (keeps repeated comments and empty lines for organization)
# (same code in import.sh)
find ./sources/domains ./sources/urls ./sources/tlds -type f -iname "*.txt" -exec bash -c '
    awk "(\$0 ~ /^[[:space:]]*#/ || NF == 0 || !seen[\$0]++)" "$0" > "$0_temp.txt";
    mv "$0_temp.txt" "$0";
' {} \;

## Combine all sources into lists
### Domains
find ./sources/domains -type f -iname "*.txt" -exec cat {} \; > ./sources/domains.txt
### Fediverse domains
find ./sources/domains -type f -iname "*fediverse*.txt" -exec cat {} \; > ./sources/fediverse_domains.txt
### URLs
find ./sources/urls -type f -iname "*.txt" -exec cat {} \; > ./sources/urls.txt
### Pages
find ./sources/pages -type f -iname "*.txt" -exec cat {} \; > ./sources/pages.txt
### TLDs
find ./sources/tlds -type f -iname "*.txt" -exec cat {} \; > ./sources/tlds.txt
### Espressions
find ./sources/expressions -type f -iname "*.txt" -exec cat {} \; > ./sources/expressions.txt
### Regex
find ./sources/regex -type f -iname "*.txt" -exec cat {} \; > ./sources/regex.txt

## Cleanup the lists
### Remove comments, inline comments and empty lines
find ./sources -maxdepth 1 -type f -iname "*.txt" -exec sed -i '/^#/d; s/#.*//; /^ *$/d' {} \;
### Sort and remove duplicates
find ./sources -maxdepth 1 -type f -iname "*.txt" -exec bash -c '
    sort -u "$0" > "$0_temp.txt";
    mv "$0_temp.txt" "$0";
' {} \;

# Generate blocklists

## Domains
python scripts/domains.py > domains.txt

## For DNS filtering
### Hosts
python scripts/hosts.py > hosts.txt
python scripts/hosts_ipv6.py > hosts_ipv6.txt
### DNSmasq
python scripts/dnsmasq.py > dnsmasq.txt
### pdnsd
python scripts/pdnsd.py > pdnsd.txt
### Unbound
python scripts/unbound.py > unbound.txt

## For browser extensions
### Adblock
python scripts/adblock.py > adblock.txt
### uBlacklist
python scripts/ublacklist.py > ublacklist.txt

## Generate Fediverse blocklists
### Domains
python scripts/fediverse_domains.py > fediverse_domains.txt
### Mastodon
python scripts/mastodon.py > mastodon.csv
### FediBlockHole
python scripts/fediblockhole.py > fediblockhole.csv
