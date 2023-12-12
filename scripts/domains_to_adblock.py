# This script converts domains.txt into a format used by ad blocking browser extensions.
# Usage:
#	python domains_to_adblock.py > adblock.txt

text_file = open("domains.txt", "r")
lines = text_file.readlines()
text_file.close()

for line in lines:
	print('||' + line.strip() + '^')
