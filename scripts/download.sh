#!/usr/bin/env bash

# Use this script to download external blocklists from a list formatted as "file.txt|url" to the "/import/original/" folder.
# e.g.
# ./scripts/download.sh < list.txt

IFS='|'
while read FILE URL; do
    curl -fL "$URL" -o ./import/original/"$FILE"
done