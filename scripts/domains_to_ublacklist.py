# This script converts domains.txt into a match pattern format used by the uBlacklist browser extension.
# Usage:
#	python domains_to_ublacklist.py > ublacklist.txt

with open("domains.txt", "r") as domains:
	linesdomains = domains.readlines()

# Additional filters
## TLDs
with open("filters/TLDs.txt", "r") as tlds:
	linestlds = tlds.readlines()

# Complete list generation
lines = linesdomains + linestlds

for line in lines:
	print('*://*.' + line.strip() + '/*')
