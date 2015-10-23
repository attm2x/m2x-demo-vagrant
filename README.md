# M2X Vagrant Demo


## Introduction

This repo provides a Vagrant virtual machine that contains several demo applications that report data to AT&T M2X:

* A Ruby application that reports the system load (on 1-minute, 5-minute, and 15-minute averages, as reported by uptime) to M2X every minute.
* A Python application that reports the current stock price of AT&T's stock (ticker symbol "T") every minute.

All the steps required to set up all demos are in bootstrap.bash, so if you want to replicate any part of this setup on your own systems, you can easily see what we've done.

Please note that the virtual machine and M2X are using times in UTC, not in your local time zone.


## Pre-Requisites

You will need to have [Vagrant](http://www.vagrantup.com/) and [VirtualBox](https://www.virtualbox.org/) installed on your computer. Both are free, and there are versions for Mac OS X, Windows, and Linux.

You will also need an [account on AT&T's M2X service](https://m2x.att.com/signup), which has a free Developer plan and usage based paid plans for higher volumes of data. Check out the [M2X Pricing](https://m2x.att.com/pricing) page for more details.

## Installation

### Vagrant Setup
Clone the m2x-demo-vagrant repository (this one) to wherever you keep code on your computer.

```
git clone https://github.com/attm2x/m2x-demo-vagrant.git
```

Next, cd to the repo you just cloned, and run "vagrant up":

```
cd m2x-demo-vagrant
vagrant up
```

This process should take between 2 and 10 minutes, depending on the speed of your computer and your network connection, and whether or not you've previously downloaded the "Precise64" Vagrant image.

### M2X API Key

Next you'll need to get your M2X API Master Key. Log into M2X, and click your name in the upper right-hand corner, then the "Account Settings" dropdown, then the "Master Keys" tab. [Here's a direct link](https://m2x.att.com/account#master-keys-tab). Copy the Master Key and paste it into the m2x_api_key.txt file. You can see an example in m2x_api_key.example.txt. It's just the API key, by itself, in a text file.


## Ruby Demo

You should now be sending data on 1-minute, 5-minute, and 15-minute load averages from your Vagrant virtual machine to AT&T M2X. It should be updating every minute, and if you refresh your AT&T M2X "loadreport" Device page, you should be able to click each load average and see graphs showing your load averages over time.

If not, you can look at loadreport.log in your repo, which records any errors in sending the data to M2X. You can also SSH to the Vagrant virtual machine with the ```vagrant ssh``` command to run standard Linux/Unix troubleshooting commands.


## Python Demo

Your stockreport.py should now be reporting the price of AT&T's stock to AT&T M2X every minute. (Please note that the NYSE is open from 9:30 AM to 4 PM Eastern Time, and the stock price reported outside those hours will not change.)

If there are any errors from stockreport.py, they will be logged in stockreport.log in your repo directory, or you can ```vagrant ssh``` to the virtual machine for troubleshooting.

## Important Note About Security

The individual demos included here do not contain any bad security examples that we're aware of. However, the bootstrap.bash script that configures the virtual machine does not update the operating system, and does not ensure it has the latest version of a number of packages. This is because updating the OS would increase tenfold the time involved in setting up this virtual machine. If you are building a production machine from this example, make sure your software gets updated.

License
=======

This library is released under the MIT license. See ``LICENSE`` for the terms.
