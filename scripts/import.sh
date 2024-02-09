#!/usr/bin/env bash

# Use this script to download and cleanup external blocklists.
# e.g.
# ./scripts/import.sh

# Download external blocklists
./scripts/download.sh < ./sources/imports/importlist.txt

# Copy to modified
cp -a ./sources/imports/original/. ./sources/imports/modified/

# Cleanup imported sources (Same code in update.sh)
## Special cleanup for imported sources of other formats (match, hosts, AdBlock, etc.)
find ./sources/imports/modified -type f -name "*.txt" -exec sed -ri 's/^\*\:\/\///i; s/^\*\.//i; s/^0\.0\.0\.0[[:space:]]*//i; s/^[^#[:alnum:]]/#&/' {} \;
## Normalizes URLs into domains: lowercases, remove leading spaces, protocol (`x://`) `www.` subdomains, everything after `/`, only one space before `#`. Keeps comments intact
find ./sources/imports/modified -type f -name "*.txt" -exec sed -ri 'h; s/[^#]*//1; x; s/#.*//; s/.*/\L&/; s/^[[:space:]]*//i; s/^.*:\/\///i; s/^[.*]*//i; s/^www\.//i; s/\/[^[:space:]]*//i; s/[[:space:]].*$/ /i; G; s/(.*)\n/\1/' {} \;
## Removing "www." twice because unmaintained imported lists are weird.
find ./sources/imports/modified -type f -name "*.txt" -exec sed -ri 's/^www\.//i' {} \; 
## Remove duplicate domains from each source file (keeps repeated comments and empty lines for organization)
find ./sources/imports/modified -type f -name "*.txt" -exec bash -c '
    awk "(\$0 ~ /^[[:space:]]*#/ || NF == 0 || !seen[\$0]++)" "$0" > "$0_temp.txt";
    mv "$0_temp.txt" "$0";
' {} \;

# Remove entries from the allowlist
find ./sources/imports/modified -type f -name "*.txt" -exec bash -c '
    grep -vxFf "./sources/imports/allowlist.txt" "$0" > "$0_temp.txt";
    mv "$0_temp.txt" "$0";
' {} \;

# Copy to sources/domains
cp -a ./sources/imports/modified/. ./sources/domains/_imported/