#!/usr/bin/env bash

# Generates all the blocklists from the content of the `sources` folder.
# Usage:
# ./scripts/update.sh

# Normalize sources

## Normalize domains: lowercases, remove leading spaces, protocol (`x://`), `www.` subdomains, path ( `/` and after), leave only one space before inline comment (`#`). Keeps comments intact
# (same code in import.sh)
find ./sources/domains -type f -iname "*.txt" -exec sed -ri 'h; s/[^#]*//1; x; s/#.*//; s/.*/\L&/; s/^[[:space:]]*//i; s/^.*:\/\///i; s/^[.*]*//i; s/^www\.//i; s/\/[^[:space:]]*//i; s/[[:space:]].*$/ /i; G; s/(.*)\n/\1/' {} \;
## Normalize URLs: lowercases, remove leading spaces, protocol (`*://*`), `www.` subdomains, leave only one space before inline comment (`#`). Keeps comments intact
find ./sources/urls -type f -iname "*.txt" -exec sed -ri 'h; s/[^#]*//1; x; s/#.*//; s/.*/\L&/; s/^[[:space:]]*//i; s/^.*:\/\///i; s/^[.*]*//i; s/^www\.//i; s/[[:space:]].*$/ /i; G; s/(.*)\n/\1/' {} \;
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
### TLDs
find ./sources/tlds -type f -iname "*.txt" -exec cat {} \; > ./sources/tlds.txt

## Cleanup the lists
### Remove comments, inline comments, spaces and empty lines
find ./sources -maxdepth 1 -type f -iname "*.txt" -exec sed -i '/^#/d; s/#.*//; s/ //g; /^ *$/d' {} \;
### Sort and remove duplicates
find ./sources -maxdepth 1 -type f -iname "*.txt" -exec bash -c '
    sort -u "$0" > "$0_temp.txt";
    mv "$0_temp.txt" "$0";
' {} \;

# Generate blocklists
§
## Domains
cp ./sources/headers/default.txt domains.txt
cat ./sources/domains.txt >> domains.txt

## For DNS filtering
### Hosts
python scripts/domains_to_hosts.py > hosts.txt
python scripts/domains_to_hosts_ipv6.py > hosts.txt.ipv6
### DNSmasq
python scripts/domains_to_dnsmasq.py > dnsmasq.txt

## For browser extensions
### Adblock
python scripts/adblock.py > adblock.txt
### uBlacklist
python scripts/domains_to_ublacklist.py > ublacklist_temp.txt
cp ./sources/headers/default.txt ublacklist.txt
cat ublacklist_temp.txt >> ublacklist.txt
rm ublacklist_temp.txt

## Generate Fediverse blocklists
### Domains
cp ./sources/fediverse_domains.txt fediverse_domains.txt
### Mastodon
python scripts/fediverse_domains_to_mastodon.py > mastodon_temp.txt
cp ./sources/headers/mastodon.csv mastodon.csv
cat mastodon_temp.txt >> mastodon.csv
rm mastodon_temp.txt
### FediBlockHole
python scripts/fediverse_domains_to_fediblockhole.py > fediblockhole_temp.txt
cp ./sources/headers/fediblockhole.csv fediblockhole.csv
cat fediblockhole_temp.txt >> fediblockhole.csv
rm fediblockhole_temp.txt