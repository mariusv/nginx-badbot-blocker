Nginx Bad Bot Blocker
===============

223 (and growing) Nginx rules to block bad bots.

Bad bots are defined as:

- E-mail harvesters
- Content scrapers
- Spam bots
- Vulnerability scanners
- Aggressive bots that provide little value
- Bots linked to viruses or malware
- Government surveillance bots
- Russian search engine Yandex
- Chinese search engine Baidu
- Spamhaus IP list block

Yandex/Baidu
------------

Unless your website is written in Russian or Chinese, you probably don't
get any traffic from them. They mostly just waste bandwidth and consume resources.


Bots Are Liars
--------------

Bots try to make themselves look like other software by disguising their
useragent. Their useragents may look harmless, perfectly legitimate even.
For example, "^Java" but according to
[Project Honeypot](https://www.projecthoneypot.org/harvester_useragents.php),
it's actually one of the most dangerous.


Spamhaus IP Block
----------------

Block Spamhaus Lasso Drop Spam IP Address. (I'll keep this list updated)

***GENERATED 19/11/2015***


Setup
-----

If you have a bizarre or complicated setup, be sure to look everything
over before using it. But for anyone with something that resembles
a standard Nginx installation, this should work without any issues as long as you include in your nginx.conf the `blacklist.conf` and `blockips.conf`.

