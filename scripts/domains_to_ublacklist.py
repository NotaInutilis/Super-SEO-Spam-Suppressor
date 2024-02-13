# This script converts domains.txt into a match pattern format used by the uBlacklist browser extension.
# Usage:
#	python domains_to_ublacklist.py > ublacklist.txt

text_file = open("sources/domains.txt", "r")
lines = text_file.readlines()
text_file.close()

for line in lines:
	print('*://*.' + line.strip() + '/*')
