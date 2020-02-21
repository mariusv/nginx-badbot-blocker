![Nginx Bad Bot Blocker - Block bad, possibly even malicious web crawlers (automated bots) using Nginx ](https://github.com/mariusv/nginx-badbot-blocker/blob/master/VERSION_2/_assets/nginx-bad-bot-blocker.png "Nginx Bad Bot Blocker - Block bad, possibly even malicious web crawlers (automated bots) using Nginx")
Nginx Bad Bot Blocker
=====================

_______________
#### Version: V2.2020.02.21
#### Bad Referrer Count: 6828
#### Bad Bot Count: 562
____________________

### Version 1 Created by: https://github.com/mariusv
### Version 2 Created by: https://github.com/mitchellkrogza/

# [Configuration and Updating Instructions](#configuration-instructions)

Bad bots are defined as:

- E-mail harvesters
- Content scrapers
- Spam bots
- Vulnerability scanners
- Aggressive bots that provide little value
- Bots linked to viruses, malware or ransomware
- Government surveillance bots
- Bad Referers
- Spam Referers
- Spam bots
- Image Hotlinking Sites and Image Thieves
- Known Wordpress Theme Detectors

Bots Are Liars
--------------

Bots try to make themselves look like other software by disguising their
useragent. Their useragents may look harmless, perfectly legitimate even.

# CONFIGURATION INSTRUCTIONS
### PLEASE READ CONFIGURATION INSTRUCTIONS BELOW THOROUGHLY

**New Super Easy Configuration Contributed by https://github.com/mitchellkrogza/**

## 1:

**COPY THE BLACKLIST.CONF FILE FROM THE REPO**

Copy the contents of **/conf.d/blacklist.conf** from the repo into your /etc/nginx/conf.d folder. 

`sudo wget https://github.com/mariusv/nginx-badbot-blocker/raw/master/VERSION_2/conf.d/blacklist.conf -O /etc/nginx/conf.d/blacklist.conf`

If your Linux distribution does not have wget you can use curl as follows

`curl -sL https://github.com/mariusv/nginx-badbot-blocker/raw/master/VERSION_2/conf.d/blacklist.conf -o /etc/nginx/conf.d/blacklist.conf`

## 2: 

**COPY THE INCLUDE FILES FROM THE REPO**

- From your command line in Linux type

`sudo mkdir /etc/nginx/bots.d `

- copy the blockbots.conf file into that folder

`sudo wget https://github.com/mariusv/nginx-badbot-blocker/raw/master/VERSION_2/bots.d/blockbots.conf -O /etc/nginx/bots.d/blockbots.conf`


- copy the ddos.conf file into the same folder

`sudo wget https://github.com/mariusv/nginx-badbot-blocker/raw/master/VERSION_2/bots.d/ddos.conf -O /etc/nginx/bots.d/ddos.conf`

## 3:

**WHITELIST ALL YOUR OWN DOMAIN NAMES AND IP ADDRESSES**

Whitelist all your own domain names and IP addresses. **Please note important changes**, this is now done using include files so that you do not have to keep reinserting your whitelisted domains and IP addresses every time you update.

- copy the whitelist-ips.conf file into that folder

`sudo wget https://github.com/mariusv/nginx-badbot-blocker/raw/master/VERSION_2/bots.d/whitelist-domains.conf -O /etc/nginx/bots.d/whitelist-domains.conf`


- copy the whitelist-domains.conf file into the same folder

`sudo wget https://github.com/mariusv/nginx-badbot-blocker/raw/master/VERSION_2/bots.d/whitelist-ips.conf -O /etc/nginx/bots.d/whitelist-ips.conf`

Use nano, vim or any other text editor to edit both whitelist-ips.conf and whitelist-domains.conf to include all your own domain names and IP addresses that you want to specifically whitelist from the blocker script. 

When pulling any future updates now you can simply pull the latest globalblacklist.conf file and it will automatically include your whitelisted domains and IP addresses.


## 4:

**INCLUDE IMPORTANT SETTINGS IN NGINX.CONF**

- From your linux command line type

- `sudo nano /etc/nginx/nginx.conf`

#####Add the following settings and rate limiting zones near the top of your nginx.conf file. This is both for the Anti DDOS rate limiting filter and for allowing Nginx to load this very large set of domain names into memory. 

- `server_names_hash_bucket_size 64;`

- `server_names_hash_max_size 4096;`

- `limit_req_zone $binary_remote_addr zone=flood:50m rate=90r/s;`

- `limit_conn_zone $binary_remote_addr zone=addr:50m;`

**Make sure** that your nginx.conf file contains the following include directive. If it's commented out make sure to uncomment it.

- `include /etc/nginx/conf.d/*`

**PLEASE NOTE:** The above rate limiting rules are for the DDOS filter, it may seem like high values to you but for wordpress sites with plugins and lots of images, it's not. This will not limit any real visitor to your Wordpress sites but it will immediately rate limit any aggressive bot. Remember that other bots and user agents are rate limited using a different rate limiting rule at the bottom of the globalblacklist.conf file.

The server_names_hash settings allows Nginx Server to load this very large list of domain names and IP addresses into memory.

## 5:

**ADD INCLUDE FILES INTO A VHOST**

Open a site config file for Nginx (just one for now) and add the following lines.

##### VERY IMPORTANT NOTE: 

These includes MUST be added within a **server {}** block of a vhost otherwise you will get EMERG errors from Nginx.

- `include /etc/nginx/bots.d/blockbots.conf;`

- `include /etc/nginx/bots.d/ddos.conf;`

## 6:

**TESTING YOUR NGINX CONFIGURATION**

`sudo nginx -t`

If you get no errors then you followed my instructions so now you can make the blocker go live with a simple.

`sudo service nginx reload`

The blocker is now active and working so now you can run some simple tests from another linux machine to make sure it's working.

## 7:

**TESTING**

Run the following commands one by one from a terminal on another linux machine against your own domain name. 
**substitute yourdomain.com in the examples below with your REAL domain name**

`curl -A "googlebot" http://yourdomain.com`

Should respond with 200 OK

`curl -A "80legs" http://yourdomain.com`

`curl -A "masscan" http://yourdomain.com`

Should respond with: curl: (52) Empty reply from server

`curl -I http://yourdomain.com -e http://100dollars-seo.com`

`curl -I http://yourdomain.com -e http://zx6.ru`

Should respond with: curl: (52) Empty reply from server

The Nginx BadBot Blocker is now working and protecting your web sites !!!

## 8:

**UPDATING THE NGINX BADBOT BLOCKER** is now easy thanks to the automatic includes for whitelisting your own domain names.

Updating to the latest version is now as simple as:

`sudo wget https://github.com/mariusv/nginx-badbot-blocker/raw/master/VERSION_2/conf.d/blacklist.conf -O /etc/nginx/conf.d/blacklist.conf`

`sudo nginx -t`

`sudo service nginx reload` 

And you will be up to date with all your whitelisted domains included automatically for you now. 

# AUTO UPDATING:

See the latest auto updater bash script at:

https://raw.githubusercontent.com/mariusv/nginx-badbot-blocker/master/VERSION_2/updatenginxblocker.sh

This can now be run as a daily cron to keep you up to date without having to remember to do it yourself. I have this cron running on 3 nginx servers for the past week pulling their updates automatically from my master, works flawlessly.

Relax now and sleep better at night knowing your site is telling all those baddies to go away !!!


### ISSUES:
Log any issues regarding incorrect listings on the issues system and they will be investigated and removed if necessary.

### PULL REQUESTS: 
To contribute your own bad referers please add them into the https://github.com/mariusv/nginx-badbot-blocker/blob/master/VERSION_2/Pull_Requests/badreferers.list file and then send a Pull Request (PR).

### UNDERSTANDS PUNYCODE / IDN DOMAIN NAMES
A lot of lists out there put funny domains into their hosts file. Your hosts file and DNS will not understand this. This list uses converted domains which are in the correct DNS format to be understood by any operating system. **Avoid using lists** that do not put the correctly formatted domain structure into their lists.

For instance
The domain:

`lifehacĸer.com` (note the K)

actually translates to:

`xn--lifehacer-1rb.com`

You can do an nslookup on any operating system and it will resolve correctly.

`nslookup xn--lifehacer-1rb.com`

```xn--lifehacer-1rb.com
	origin = dns1.yandex.net
	mail addr = iskalko.yandex.ru
	serial = 2016120703
	refresh = 14400
	retry = 900
	expire = 1209600
	minimum = 14400
xn--lifehacer-1rb.com	mail exchanger = 10 mx.yandex.net.
Name:	xn--lifehacer-1rb.com
Address: 78.110.60.230
xn--lifehacer-1rb.com	nameserver = dns2.yandex.net.
xn--lifehacer-1rb.com	text = "v=spf1 redirect=_spf.yandex.net"
xn--lifehacer-1rb.com	nameserver = dns1.yandex.net.
```

- Look at: https://www.charset.org/punycode for more info on this.

## MONITOR WHAT YOU ARE DOING:

**MAKE SURE to monitor your web site logs** after implementing this. I suggest you first load this into one site and monitor it for any possible false positives before putting this into production on all your web sites.

Do not sit like an ostrich with your head in the sand, being a responsible server operator and web site owner means you must monitor your logs frequently. A reason many of you ended up here in the first place because you saw nasty looking stuff in your Nginx log files.
 
Also monitor your logs daily for new bad referers and user-agent strings that you want to block. Your best source of adding to this list is your own server logs, not mine.
 
Feel free to contribute bad referers from your own logs to this project by sending a Pull Request (PR). You can however rely on this list to keep out 99% of the baddies out there.
 
## Blocking Agressive Bots at Firewall Level Using Fail2Ban

We have added a custom Fail2Ban filter and action written by mitchellkrogza which monitors your Nginx logs for bots that generate a large number of 444 errors. This custom jail for Fail2Ban will scan logs over a 1 week period and ban the offender for 24 hours.
It helps a great deal in keeping out some repeat offenders and preventing them from filling up your log files with 444 errors. See the Fail2Ban folder for instructions on configuring this great add on for the Nginx Bot Blocker.

## Contributors

- Konstantin Goretzki @konstantingoretzki https://github.com/konstantingoretzki (Improved Regex on Fail2Ban Filter)


