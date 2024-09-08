#!/usr/bin/env bash

# Downloads and cleanup external blocklists to domains format.
# Usage:
# ./scripts/import.sh

# Download external blocklists
./scripts/download.sh < ./sources/imports/importlist.txt

# Copy to modified
cp -a ./sources/imports/original/. ./sources/imports/modified/

# Cleanup imported sources
## Special cleanup for imported sources of other formats (match, hosts, AdBlock, etc.)
find ./sources/imports/modified -type f -iname "*.txt" -exec sed -ri 's/^\*\:\/\///i; s/^\*\.//i; s/^0\.0\.0\.0[[:space:]]*//i; s/^127\.0\.0\.1[[:space:]]*//i; s/^255\.255\.255\.255[[:space:]]*//i; s/^\:\:1[[:space:]]*//i; s/^fe80\:\:1\%lo0[[:space:]]*//i; s/^[[:space:]]*localhost[[:space:]]*$//i; s/^[[:space:]]*localhost.localdomain[[:space:]]*$//i; s/^[[:space:]]*local[[:space:]]*$//i; s/^[[:space:]]*broadcasthost[[:space:]]*$//i; s/^[^#[:alnum:]]/#&/' {} \;
## Normalize domains: lowercases, remove leading spaces, protocol (`x://`), `www.` subdomains, path ( `/` and after), leave only one space before inline comment (`#`). Keeps comments intact
# (same code in update.sh)
find ./sources/imports/modified -type f -iname "*.txt" -exec sed -ri 'h; s/[^#]*//1; x; s/#.*//; s/.*/\L&/; s/^[[:space:]]*//i; s/^.*:\/\///i; s/^[.*]*//i; s/^www\.//i; s/\/[^[:space:]]*//i; s/[[:space:]].*$/ /i; G; s/(.*)\n/\1/' {} \;
## Removing "www." again because unmaintained imported lists are weird.
find ./sources/imports/modified -type f -iname "*.txt" -exec sed -ri 's/^www\.//i' {} \; 
## Remove duplicate domains from each source file (keeps repeated comments and empty lines for organization)
# (same code in update.sh)
find ./sources/imports/modified -type f -iname "*.txt" -exec bash -c '
    awk "(\$0 ~ /^[[:space:]]*#/ || NF == 0 || !seen[\$0]++)" "$0" > "$0_temp.txt";
    mv "$0_temp.txt" "$0";
' {} \;

# Remove entries from the allowlist
find ./sources/imports/modified -type f -iname "*.txt" -exec bash -c '
    grep -vxFf "./sources/imports/allowlist.txt" "$0" > "$0_temp.txt";
    mv "$0_temp.txt" "$0";
' {} \;

# Copy to sources/domains
cp -a ./sources/imports/modified/. ./sources/domains/_imported/