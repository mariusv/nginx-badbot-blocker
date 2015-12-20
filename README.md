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
- ~~~Russian search engine Yandex~~~ (Per users request Yandex was removed)
- Chinese search engine Baidu
- Spamhaus IP list block

Baidu
------------

Unless your website is written in Chinese, you probably don't
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

Copy both `blacklist.conf` and `blockips.conf` in your nginx directory (usually is in `/etc/nginx` but this can differ if nginx was compiled).
Once you copied the files edit `nginx.conf` and under(usually at the end of the file) the `http` block add this lines:

```bash
## Include blacklist for bad bot and referrer blocking.
include blacklist.conf;
include blockips.conf;
```

