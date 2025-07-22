#!/usr/bin/env python3
"""
Generate an Unbound compatible configuration file of domains to refuse from the content of the `sources` folder.

Usage:
  python unbound.py > unbound.txt
"""


def get_header() -> str:
    """Return header for Unbound config file"""
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


def format_unbound(domain: str) -> str:
    """Return entry formatted for Unbound"""
    return f"local-zone: \"{domain.strip()}\" always_refuse"


def main() -> None:
    """Print out an Unbound config file ready to include"""
    print(get_header())
    for domain in sorted(get_domains()):
        print(format_unbound(domain))


if __name__ == "__main__":
    main()
