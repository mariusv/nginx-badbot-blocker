Nginx Bad Bot Blocker
===============

**223 (and growing) Nginx rules to block bad bots.**

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


## Installation

If you have a bizarre or complicated setup, be sure to look everything
over before installing. However, for anyone with a fairly straightforward Nginx installation, this should work without any issues. 

**Step 1.)** Clone the Nginx Bad Bot Blocker repository into your Nginx directory.

```
cd /etc/nginx
git clone https://github.com/mariusv/nginx-badbot-blocker.git
```

**Step 2.)** Edit `/etc/nginx/nginx.conf` and add the following at the end of the `http` block, before the closing `}`

```
##
# Nginx Bad Bot Blocker
##
include nginx-badbot-blocker/blacklist.conf;
include nginx-badbot-blocker/blockips.conf;
```

**Step 3.)** Run the following command to verify your Nginx configuration is valid. (*Note: You may need to prepend sudo to this command.*)

```
nginx -t
```

You should get an output that looks something like this:

```
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
```

**Step 4.)** Reload Nginx and you're all set!

```
sudo service nginx reload
```

---

## Further information

### Baidu

Unless your website is written in Chinese, you probably don't
get any traffic from them. They mostly just waste bandwidth and consume resources.


### Bots Are Liars

Bots try to make themselves look like other software by disguising their
useragent. Their useragents may look harmless, perfectly legitimate even.
For example, "^Java" but according to
[Project Honeypot](https://www.projecthoneypot.org/harvester_useragents.php),
it's actually one of the most dangerous.


### Spamhaus IP Block

Block Spamhaus Lasso Drop Spam IP Address. (I'll keep this list updated)

***UPDATED 16/01/2018***

