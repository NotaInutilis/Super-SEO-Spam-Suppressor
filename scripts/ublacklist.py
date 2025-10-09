# Generates a list in the match pattern format for the the uBlacklist browser extension from the content of the `sources` folder.
# Usage:
# python ublacklist.py > ublacklist.txt

# Open header
with open("sources/headers/ublacklist.txt", "r") as header:
	linesheader = header.readlines()

# Open blocked formats
with open("sources/domains.txt", "r") as domains:
	linesdomains = domains.readlines()
with open("sources/tlds.txt", "r") as tlds:
	linestlds = tlds.readlines()
with open("sources/urls.txt", "r") as urls:
	linesurls = urls.readlines()
blocklist = linesdomains + linestlds + linesurls

with open("sources/pages.txt", "r") as pages:
	linespages = pages.readlines()

with open("sources/expressions.txt", "r") as expressions:
	linesexpressions = expressions.readlines()

with open("sources/regex.txt", "r") as regex:
	linesregex = regex.readlines()

# Print blocklist
for line in linesheader:
	print(line.strip())
print()
for line in blocklist:
	print('*://*.' + line.strip() + '/*')
for line in linespages:
	print('*://*.' + line.strip() + '*')
for line in linesexpressions:
	print(line.strip())
for line in linesregex:
	print(line.strip())
