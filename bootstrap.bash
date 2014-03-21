#!/usr/bin/env bash

apt-get update

### Set up Ruby M2X example

# Set up Ruby environment for M2X
# NOTE: In a production environment, you should install a more up-to-date Ruby.
# We don't here for the sake of a quick first-start time for this VM.
apt-get -y install ruby1.9.3
gem update
gem install m2x

# Set up loadreport.rb to run every minute
chmod 754 /vagrant/loadreport.rb
cp /vagrant/loadreport.cron /etc/cron.d/loadreport

# Keep loadreport.log from getting too large
cp /vagrant/loadreport.logrotate /etc/logrotate.d/loadreport



### Set up Python M2X Example
apt-get -y install python-pip
pip install m2x
pip install ystockquote


