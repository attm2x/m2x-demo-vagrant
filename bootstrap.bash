#!/usr/bin/env bash

apt-get update

# Set up Ruby environment for M2X
apt-get -y install ruby1.9.3
gem update
gem install m2x

# Set up loadreport.rb to run every minute
chmod 754 /vagrant/loadreport.rb
cp /vagrant/loadreport.cron /etc/cron.d/loadreport

# Keep loadreport.log from getting too large
cp /vagrant/loadreport.logrotate /etc/logrotate.d/loadreport
