# This script converts domains.txt into dnsmasq's blocking syntax.
# Usage:
#	python domains_to_dnsmasq.py > dnsmasq.txt

with open("domains.txt", "r") as domains:
	linesdomains = domains.readlines()

# Additional filters
## TLDs
with open("filters/TLDs.txt", "r") as tlds:
	linestlds = tlds.readlines()

# Complete list generation
lines = linesdomains + linestlds

for line in lines:
	print('address=/' + line.strip() + '/')
