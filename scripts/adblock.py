# Generates a list formatted for ad blocking browser extensions from the content of the `sources` folder.
# Usage:
# python adblock.py > adblock.txt

# Open header
with open("sources/headers/adblock.txt", "r") as header:
	linesheader = header.readlines()

# Open blocked formats
with open("sources/domains.txt", "r") as domains:
	linesdomains = domains.readlines()
with open("sources/tlds.txt", "r") as tlds:
	linestlds = tlds.readlines()
with open("sources/urls.txt", "r") as urls:
	linesurls = urls.readlines()
with open("sources/pages.txt", "r") as pages:
	linespages = pages.readlines()
blocklist = linesdomains + linestlds + linesurls + linespages

with open("sources/regex.txt", "r") as regex:
	linesregex = regex.readlines()

# Print blocklist
for line in linesheader:
	print(line.strip())
print()
for line in blocklist:
	print('||' + line.strip() + '^$document')
for line in linesregex:
	print(line.strip())