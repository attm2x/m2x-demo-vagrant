#!/usr/bin/env bash

set -e

apt-get update

### Set up Ruby M2X example
echo "Setting up Ruby demo..."
# Set up Ruby environment for M2X
# NOTE: In a production environment, you should install a more up-to-date Ruby.
# We don't here for the sake of a quick first-start time for this VM.
apt-get -y install ruby1.9.3
if gem list | grep -q m2x ; then
    echo "m2x gem already installed. Updating..."
    gem update m2x
else
    echo "Installing m2x gem..."
    gem install m2x
fi

# Set up loadreport.rb to run every minute
chmod 754 /vagrant/loadreport.rb
cp /vagrant/loadreport.cron /etc/cron.d/loadreport
chmod 644 /etc/cron.d/loadreport

# Keep loadreport.log from getting too large
cp /vagrant/loadreport.logrotate /etc/logrotate.d/loadreport


### Set up Python M2X Example
echo "Setting up Python demo..."
apt-get -y install python-pip
pip install m2x --upgrade

# These are needed for our example in particular.
pip install ystockquote --upgrade
pip install pyyaml --upgrade

chmod 754 /vagrant/stockreport.py
cp /vagrant/stockreport.cron /etc/cron.d/stockreport
chmod 644 /etc/cron.d/stockreport
cp /vagrant/stockreport.logrotate /etc/logrotate.d/stockreport

echo "Done setting up demos."
