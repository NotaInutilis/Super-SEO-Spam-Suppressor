# Generates a plain domains list from the content of the `sources` folder.
# Usage:
# python domains.py > domains.txt

# Open header
with open("sources/headers/default.txt", "r") as header:
	linesheader = header.readlines()

# Open blocked formats
with open("sources/domains.txt", "r") as domains:
	linesdomains = domains.readlines()
blocklist = linesdomains

# Print blocklist
for line in linesheader:
	print(line.strip())
print()
for line in blocklist:
	print(line.strip())
