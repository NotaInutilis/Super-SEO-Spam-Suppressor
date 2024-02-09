#!/usr/bin/env bash

# Use this script to download external blocklists from a list formatted as "file.txt|url" to the "/imports/original/" folder.
# e.g.
# ./scripts/download.sh < list.txt

IFS='|'
while read FILE URL; do
    curl -fL "$URL" -o ./sources/imports/original/"$FILE"
done