# This script converts domains.txt into a format used by ad blocking browser extensions.
# Usage:
#	python domains_to_adblock.py > adblock.txt

with open("domains.txt", "r") as domains:
	linesdomains = domains.readlines()

# Additional filters
## TLDs
with open("filters/TLDs.txt", "r") as tlds:
	linestlds = tlds.readlines()

# Complete list generation
lines = linesdomains + linestlds

for line in lines:
	print('||' + line.strip() + '^')
