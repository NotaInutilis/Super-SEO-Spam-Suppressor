#!/usr/bin/env bash

# Use this script to generate all the blocklists using the `.txt` files in the `sources` folder.
# e.g.
# ./scripts/update.sh

# Cleanup sources:
## Normalizes URLs into domains: lowercases, remove leading spaces, protocol (`x://`) `www.` subdomains, everything after `/`, only one space before `#`. Keeps comments intact.
find ./sources -type f -name "*.txt" -exec sed -ri 'h; s/[^#]*//1; x; s/#.*//; s/.*/\L&/; s/^[[:space:]]*//i; s/^.*:\/\///i; s/^[.*]*//i; s/^www\.//i; s/\/[^[:space:]]*//i; s/[[:space:]].*$/ /i; G; s/(.*)\n/\1/' {} \;
## Remove duplicate domains from each source file (keeps repeated comments and empty lines for organization).
find ./sources -type f -name "*.txt" -exec bash -c '
    awk "(\$0 ~ /^[[:space:]]*#/ || NF == 0 || !seen[\$0]++)" "$0" > "$0_temp.txt";
    mv "$0_temp.txt" "$0";
' {} \;

# Combine all sources into a domains list.
find ./sources -type f -name "*.txt" -exec cat {} \; > domains.txt

# Cleanup the domain list:
## Remove comments, inline comments, spaces and empty lines.
sed -i '/^#/d; s/#.*//; s/ //g; /^ *$/d' domains.txt
## Sort and remove duplicates.
sort -u domains.txt > domains_temp.txt
mv domains_temp.txt domains.txt

# Generate blocklists:
## From the domain list.
python scripts/domains_to_hosts.py > hosts.txt
python scripts/domains_to_hosts_ipv6.py > hosts.txt.ipv6
python scripts/domains_to_dnsmasq.py > dnsmasq.txt

## For browser extensions.
python scripts/domains_to_adblock.py > adblock_temp.txt
cp ./headers/adblock.txt adblock.txt
cat adblock_temp.txt >> adblock.txt
rm adblock_temp.txt
python scripts/domains_to_ublacklist.py > ublacklist_temp.txt
cp ./headers/adblock.txt ublacklist.txt # Currently using the same adblock header until uBlacklist implements its own header. https://github.com/iorate/ublacklist/issues/351
cat ublacklist_temp.txt >> ublacklist.txt
rm ublacklist_temp.txt