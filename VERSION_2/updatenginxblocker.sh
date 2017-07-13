#!/bin/bash
# Bash Script for Auto Updating the Nginx Bad Bot Blocker
# Copyright - https://github.com/mitchellkrogza
# Project Url: https://github.com/mariusv/nginx-badbot-blocker

# MAKE SURE you have your whitelist-ips.conf and whitelist-domains.conf files in /etc/nginx/bots.d
# PLEASE READ UPDATED CONFIGURATION INSTRUCTIONS BEFORE USING THIS

# Save this file as /bin/updatenginxblocker.sh
# Make it Executable chmod +x /bin/updatenginxblocker.sh

# RUN THE UPDATE
# Here our script runs, pulls the latest update, reloads nginx and emails you a notification
# Place your own valid email address where it says "me@myemail.com"
 
sudo wget https://github.com/mariusv/nginx-badbot-blocker/raw/master/VERSION_2/conf.d/blacklist.conf -O /etc/nginx/conf.d/blacklist.conf
sudo service nginx reload | mail -s "Nginx Bad Bot Blocker Updated" me@myemail.com
exit 0

# Add this as a cron to run daily / weekly as you like
# Here's a sample CRON entry to update every day at 10pm
# 00 22 * * * /bin/updatenginxblocker.sh
