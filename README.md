# Super SEO Spam Suppressor

Super SEO Spam Suppressor (SSSS[^SSSS]) is a domains blocklist of sites abusing SEO tactics to spam web searches with advertisement, empty content (monetized with ads) and malware (looking like ads). It is best used with uBlacklist or Search Engine Spam Blocker.

[^SSSS]: It's a Gridman reference. I'm spelling it out because it's also the name of a skin disease: don't go looking for SSSS on image search.

As of now, present day, time of writing year 2023, Google is now a terminally enshittified mess, merely a husk of the wonderful discovery tool it was yesterday.
Do you want to learn about *thing*?
How about **buying** *thing* and **consuming** *thing* instead?
Its drive to commercialize our every online interaction also has consequences on other, much more user friendly search engines such as DuckDuckGo, whose indexers crawl through shit optimized for Google's terrible algorithm.
This list is, as any good adblocking tool is, an attempt to escape this neverending capitalist coercition and attention theft.
All of the tech giants play this game so consider also using a social media blocklist.

## Browser extensions

### uBlacklist syntax

[Blocklist in uBlacklist format](https://raw.githubusercontent.com/NotaInutilis/Super-SEO-Spam-Suppressor/master/ublacklist.txt) to use with [uBlacklist](https://github.com/iorate/ublacklist). It removes blocked sites from search engine results.

[Click here to subscribe.](https://iorate.github.io/ublacklist/subscribe?name=Super%20SEO%20Spam%20Suppressor&url=https://raw.githubusercontent.com/NotaInutilis/Super-SEO-Spam-Suppressor/master/ublacklist.txt) (This automatic subscription link is only compatible with Chrome)

### Domains list

[Domains list format](https://raw.githubusercontent.com/NotaInutilis/Super-SEO-Spam-Suppressor/master/domains.txt) to use with [Search Engine Spam Blocker](https://github.com/no-cmyk/Search-Engine-Spam-Blocker). It removes blocked sites from search engine results.

### AdBlock Plus syntax

[Blocklist in AdBlock format](https://raw.githubusercontent.com/NotaInutilis/Super-SEO-Spam-Suppressor/master/adblock.txt) to use with an adblocker ([uBlock Origin](https://ublockorigin.com), [Adguard](https://adguard.com)…) or Adguard Home. It uses a [strict blocking rule](https://github.com/gorhill/uBlock/wiki/Strict-blocking) to block access to those sites on your browser.

[Click here to subscribe.](https://subscribe.adblockplus.org/?location=https://raw.githubusercontent.com/NotaInutilis/Super-SEO-Spam-Suppressor/master/adblock.txt&title=Super%20SEO%20Spam%20Suppressor)

## Hosts format

[Blocklist in Hosts format](https://raw.githubusercontent.com/NotaInutilis/Super-SEO-Spam-Suppressor/master/hosts.txt) to use in a [hosts](https://en.wikipedia.org/wiki/Hosts_(file)) file or PiHole.

[IPV6 version](https://raw.githubusercontent.com/NotaInutilis/Super-SEO-Spam-Suppressor/master/hosts.txt.ipv6).

Known issue: Firefox's DNS over HTTPS option bypasses the computer's hosts file ruleset. https://bugzilla.mozilla.org/show_bug.cgi?id=1453207

## Dnsmasq format

[Blocklist in Dnsmasq format](https://raw.githubusercontent.com/NotaInutilis/Super-SEO-Spam-Suppressor/master/dnsmasq.txt) to use with the [Dnsmasq](https://thekelleys.org.uk/dnsmasq/doc.html) DNS server software.

## How to contribute

Clone this repository and add new domains in the appropriate `.txt` files in the `sources` folder. If you do not want to categorize, just put it in the `sources/default.txt` file and it will be blocked.

> For the `https://www.example.com` website, add `example.com` to the `sources/default.txt` file.

Then, when you push your changes to the `sources` folder, GitHub actions should kick in and automatically generate new versions of the blocklists. Should you want to generate them yourself, you can run the `scripts/update.sh` script (prerequisites : bash, python).

Finally, make a pull request: we'll review and approve it within a few days.

### Categorization

Blocked sites are organized using subfolders and `.txt` files in the `sources` folder. Use markdown (`.md`) files and comments (`#`) to add more information and references.

### How to contribute (easy mode)

If you have no idea how Git works, you can still contribute! Just [open an issue](https://github.com/NotaInutilis/Super-SEO-Spam-Suppressor/issues) with the URLs you would like to add to the list, grouping them by language and categories if possible. We'll check and add them shortly.

### Report malicious websites

The next best thing to do after adding a malicious website (malware, phishing, scam) to this list is to to report it so it actually doesn't show up in searches, or even gets taken offline by its host or registrar!
Here's a video guide on how to do it: [How Anyone Can DESTROY A Scam Website in Minutes 😤 (Scammers Will HATE This)](https://www.youtube.com/watch?v=0fIUiv9-UFk).

Sites to report malicious URLs:
- Search engines:
    - [Google SafeBrowsing](https://safebrowsing.google.com/safebrowsing/report_phish/)
    - [Microsoft](https://www.microsoft.com/wdsi/support/report-unsafe-site)
- Cybersecurity providers:
    - [Fortiguard](https://www.fortiguard.com/webfilter)
    - [BrightCloud](https://www.brightcloud.com/tools/url-ip-lookup.php)
    - [CRDF](https://threatcenter.crdf.fr/submit_url.html)
    - [Netcraft](https://report.netcraft.com/report)
    - [Palo Alto Networks](https://urlfiltering.paloaltonetworks.com/)
    - [ESET](https://phishing.eset.com/report)
    - [Trend Micro](https://global.sitesafety.trendmicro.com/index.php)
    - [Forcepoint](https://csi.forcepoint.com/)
    - [Spam404](https://www.spam404.com/report.html)
    - [Cisco Talos](https://talosintelligence.com/reputation_center)
    - [URLhaus](https://urlhaus.abuse.ch/browse/)
- Antivirus publishers:
    - [BitDefender](https://www.bitdefender.com/consumer/support/answer/29358/)
    - [McAfee](https://sitelookup.mcafee.com/)
    - [Symantec](https://sitereview.symantec.com/#/)
    - [Kaspersky](https://opentip.kaspersky.com/)
    - [Avira](https://www.avira.com/en/analysis/submit-url)
    - [Avast](https://www.avast.com/report-malicious-file.php)
- Phishing databases:
    - [Phishing Initiative](https://phishing-initiative.eu/contrib/)
    - [PhishTank](https://www.phishtank.com/add_web_phish.php)
    - [OpenPhish](https://openphish.com/) via [e-mail](mailto:report@openphish.com)

## Credits

This blocklist is left in the public domain.

This blocklist borrows:
- the blocklist generation code and readme that I co-wrote for rimu's [No-QAnon](https://github.com/NotaInutilis/Super-SEO-Spam-Suppressor) blocklist which is distributed under the [anti-fascist licence](https://github.com/NotaInutilis/Super-SEO-Spam-Suppressor/blob/master/LICENSE.txt).
- the full domain blocklist of quenhus' [uBlock-Origin-dev-filter](https://github.com/quenhus/uBlock-Origin-dev-filter) which is in [the public domain (unlicence)](https://github.com/quenhus/uBlock-Origin-dev-filter/blob/main/LICENSE).
- the full domain blocklist of no-cmyk's [Search Engine Spam Blocklist](https://github.com/no-cmyk/Search-Engine-Spam-Blocklist) which has no licence.
- the full domain blocklist of franga2000's [Search Engine Spam Blocklist](https://github.com/franga2000/aliexpress-fake-sites) which has no licence.
- a few entries from one of DandelionSprout's "Ad Removal List for Unusual Ads" on the [adfilt](https://github.com/DandelionSprout/adfilt) blocklist repository which is distributed under the [Dandelicence](https://github.com/DandelionSprout/adfilt/blob/master/LICENSE.md).

## Other useful lists

[Jmdugan Blocklists](https://github.com/jmdugan/blocklists/tree/master/corporations): consider blocking social media and big tech corporations.