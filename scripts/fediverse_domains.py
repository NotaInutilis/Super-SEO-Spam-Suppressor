# Generates a plain domains list from the Fediverse content of the `sources` folder.
# Usage:
# python fediverse_domains.py > fediverse_domains.txt

# Open header
with open("sources/headers/default.txt", "r") as header:
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
	print(line.strip())
