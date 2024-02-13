# This script converts domains.txt into a hosts file format for IPv6.
# Usage:
#	python domains_to_hosts_ipv6.py > hosts.txt.ipv6

text_file = open("sources/domains.txt", "r")
lines = text_file.readlines()
text_file.close()

for line in lines:
	print('::1 ' + line.strip())
	print('::1 www.'+ line.strip())
