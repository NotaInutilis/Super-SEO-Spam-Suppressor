# Generates a .csv format used by FediBlockHole from the Fediverse content of the `sources` folder.
# Usage:
# python fediblockhole.py > fediblockhole.csv

# Open header
with open("sources/headers/fediblockhole.csv", "r") as header:
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
	print(line.strip() + ',suspend,Super-SEO-Spam-Blocker blocklist,Super-SEO-Spam-Blocker blocklist')
