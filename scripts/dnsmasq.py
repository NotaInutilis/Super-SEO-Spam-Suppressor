# Generates a list in dnsmasq's blocking syntax from the content of the `sources` folder.
# Usage:
# python dnsmasq.py > dnsmasq.txt

# Open header
with open("sources/headers/default.txt", "r") as header:
	linesheader = header.readlines()

# Open blocked formats
with open("sources/domains.txt", "r") as domains:
	linesdomains = domains.readlines()
with open("sources/tlds.txt", "r") as tlds:
	linestlds = tlds.readlines()
blocklist = linesdomains + linestlds

# Print blocklist
for line in linesheader:
	print(line.strip())
print()
for line in blocklist:
	print('address=/' + line.strip() + '/')
