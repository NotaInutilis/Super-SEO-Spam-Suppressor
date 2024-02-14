# Generates a list the hosts file format from the content of the `sources` folder.
# Usage:
# python hosts.py > hosts.txt

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
	print('0.0.0.0 ' + line.strip())
	print('0.0.0.0 www.' + line.strip())
