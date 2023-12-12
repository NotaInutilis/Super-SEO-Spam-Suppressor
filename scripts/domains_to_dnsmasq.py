# This script converts domains.txt into dnsmasq's blocking syntax.
# Usage:
#	python domains_to_dnsmasq.py > dnsmasq.txt

text_file = open("domains.txt", "r")
lines = text_file.readlines()
text_file.close()

for line in lines:
	print('address=/' + line.strip() + '/')
