#!/usr/bin/env python3
"""
Generate a pdnsd compatible configuration file of domains to negate from the content of the `sources` folder.

Usage:
  python pdsnd.py > pdnsd.txt
"""


def get_header() -> str:
    """Return header for pdnsd config file"""
    with open("sources/headers/default.txt", "r") as header:
        return header.read()


def get_domains() -> set:
    """Return set of domains to block"""
    domains = set()  # Using set to eliminate potential duplicates
    with open("sources/tlds.txt", "r") as tld_list:
        for d in tld_list.readlines():
            domains.add(d.strip())
    with open("sources/domains.txt", "r") as domain_list:
        for d in domain_list.readlines():
            domains.add(d.strip())
    return domains


def format_pdnsd(domain: str) -> str:
    """Return entry formatted for pdnsd"""
    return "neg {{name={}; types=domain;}}".format(domain.strip())


def main() -> None:
    """Print out a full pdnsd config file ready to include"""
    print(get_header())
    for domain in sorted(get_domains()):
        print(format_pdnsd(domain))


if __name__ == "__main__":
    main()
