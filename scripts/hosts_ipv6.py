# Generates a list the hosts file format for IPv6 from the content of the `sources` folder.
# Usage:
# python hosts_ipv6.py > hosts_ipv6.txt

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
	print('::1 ' + line.strip())
	print('::1 www.' + line.strip())
