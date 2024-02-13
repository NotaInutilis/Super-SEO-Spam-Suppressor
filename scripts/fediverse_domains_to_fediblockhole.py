# This script converts fediverse_domains.txt into a .csv format used by FediBlockHole.
# Adds a comment for this specific blocklist (Super-SEO-Spam-Blocker)
# Usage:
#	python fediverse_domains_to_fediblockhole.py > fediblockhole.txt

text_file = open("sources/fediverse_domains.txt", "r")
lines = text_file.readlines()
text_file.close()

for line in lines:
	print(line.strip() + ',suspend,Super-SEO-Spam-Blocker blocklist,Super-SEO-Spam-Blocker blocklist')