# Generates a .csv format used by Mastodn from the Fediverse content of the `sources` folder.
# Usage:
# python mastodon.py > mastodon.csv

# Open header
with open("sources/headers/mastodon.csv", "r") as header:
	linesheader = header.readlines()

# Open blocked formats
with open("sources/fediverse_domains.txt", "r") as domains:
	linesfedidomains = domains.readlines()
blocklist = linesfedidomains

# Print blocklist
for line in linesheader:
	print(line.strip())
print()
for line in blocklist:
	print(line.strip() + ',suspend,false,false,Super-SEO-Spam-Blocker blocklist,false')
