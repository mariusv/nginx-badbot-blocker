![Nginx Bad Bot Blocker - Block bad, possibly even malicious web crawlers (automated bots) using Nginx ](https://github.com/mariusv/nginx-badbot-blocker/blob/master/VERSION_2/nginx-bad-bot-blocker.png "Nginx Bad Bot Blocker - Block bad, possibly even malicious web crawlers (automated bots) using Nginx")
Nginx Bad Bot Blocker
=====================

### Version 2.2017.01

### Version 1 Created by: https://github.com/mariusv
### Version 2 Created by: https://github.com/mitchellkrogza/

Over 4500 (and growing) Nginx rules to block bad bots.

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

#### For Nginx Web Server - https://www.nginx.com/

## SETUP INSTRUCTIONS & CONFIGURATION OF THE NGINX BAD BOT BLOCKER:

###1. Copy the /conf.d/blacklist.conf file to /etc/nginx/conf.d/blacklist.conf

If your Nginx is setup correctly you will see an include statement in your nginx.conf file as follows
`Include /etc/nginx/conf.d/*;`
This automatically makes Nginx load anything in conf.d into memory available to all sites.

**Make sure to get the RAW (unformatted) code by clicking the RAW button**

###2. Copy the blockbots.conf and ddos.conf files into /etc/nginx/bots.d

`sudo mkdir /etc/nginx/bots.d `
- copy the blockbots.conf file into that folder
- copy the ddos.conf file into the same folder

**Make sure to get the RAW (unformatted) code by clicking the RAW button**

###3. Add the following settings and rate limiting zones near the top of your nginx.conf file. This is both for the Anti DDOS rate limiting filter and for allowing Nginx to load this very large set of domain names into memory. 

- `server_names_hash_bucket_size 64;`

- `server_names_hash_max_size 4096;`

- `limit_req_zone $binary_remote_addr zone=flood:50m rate=90r/s;`

- `limit_conn_zone $binary_remote_addr zone=addr:50m;`

The above rate limiting rules are for the DDOS filter, it may seem like high values to you but for wordpress sites with plugins and lots of images, it's not. This will not limit any real visitor to your Wordpress sites but it will immediately rate limit any aggressive bot. Remember that other bots and user agents are rate limited using a different rate limiting rule at the bottom of the globalblacklist.conf file.

The server_names_hash settings allows Nginx Server to load this very large list of domain names and IP addresses into memory.

###4. Add the includes to a vhost to test (must be within a server {} block)

Open a site config file for Nginx (just one for now) and add the following lines within your server {} block.
##### MUST be added within a server {} block otherwise you will get EMERG errors from Nginx

- `include /etc/nginx/bots.d/blockbots.conf;`
- `include /etc/nginx/bots.d/ddos.conf;`

###5. Whitelist your own IP adresses

 Make sure to edit the blacklist.conf file near the bottom there is a section to whitelist your own
 IP addresses. Please add all your own IP addresses there before putting this into operation.

###6. Test the config of Nginx before reloading to make sure you followed these instructions properly.

sudo nginx -t (make sure it returns no errors and if none then)
sudo service nginx reload


### Issues:
Log any issues regarding incorrect listings on the issues system and they will be investigated
and removed if necessary.

## WARNING:
  Make sure to add all your own IP addresses the white list section near the bottom of the 
  blacklist.conf file !!!!

## MONITOR WHAT YOU ARE DOING:

 MAKE SURE to monitor your web site logs after implementing this. We suggest you first
 load this into one site and monitor it for any possible false positives before putting
 this into production on all your web sites.
 
 Also monitor your logs daily for new bad referers and user-agent strings that you
 want to block. Your best source of adding to this list is your own server logs, not mine.
 
 Feel free to contribute bad referers from your own logs to this project by sending a PR.
 

## Blocking Agressive Bots at Firewall Level Using Fail2Ban

We have added a custom Fail2Ban filter and action written by mitchellkrogza which monitors your Nginx logs for bots that generate
a large number of 444 errors. This custom jail for Fail2Ban will scan logs over a 1 week period and ban the offender for 24 hours.
It helps a great deal in keeping out some repeat offenders and preventing them from filling up your log files with 444 errors.
See the Fail2Ban folder for instructions on configuring this great add on for the Nginx Bot Blocker.

