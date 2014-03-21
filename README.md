# M2X Vagrant Demo


## Introduction

This repo provides a Vagrant virtual machine that contains several demo applications that report data to AT&T M2X:

* A Ruby application that reports the system load (on 1-minute, 5-minute, and 15-minute averages, as reported by uptime) to M2X every minute.
* A Python application that reports the current stock price of AT&T's stock (ticker symbol "T") every five minutes.

All the steps required to set up all demos are in bootstrap.bash, so if you want to replicate any part of this setup on your own systems, you can easily see what we've done.

## Pre-Requisites

You will need to have [Vagrant](http://www.vagrantup.com/) and [VirtualBox](https://www.virtualbox.org/) installed on your computer. Both are free, and have versions for Mac OS X, Windows, and Linux.

You will also need an account on [m2x.att.com](https://m2x.att.com), which is currently free to everyone. (Future plans call for M2X to keep a free "Developer" plan, but to charge for very large volumes of data.)

## Installation
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

While you're waiting, you may as well create the Data Source Blueprint you'll need for the Ruby demo



## Setting up the Ruby Demo

Log into [m2x.att.com](https://m2x.att.com) and create a Data Source Blueprint.

The Data Source Name should be "Vagrant Load" and the Data Source Description should be "System Load Averages". It should be a Private Data Source.

Copy **loadreport_feed_info.yaml.example** to **loadreport_feed_info.yaml** in your local repo, and edit it to put in your API key and your Feed ID. Both are visible on the data source blueprint page on m2x.att.com.

You should now be sending data on 1-minute, 5-minute, and 15-minute load averages from your Vagrant virtual machine to AT&T M2X. It should be updating every minute, and if you refresh your AT&T M2X "Vagrant Load" Blueprint page, you should be able to click each load average and see graphs showing your load averages over time.

If not, you can look at loadreport.log in your repo, which records any errors in sending the data to M2X. You can also SSH to the Vagrant virtual machine with the ```vagrant ssh``` command to run any standard Linux/Unix commands.


## Setting up the Python Demo

In the m2x-demo-vagrant repo that you checked out, copy **stockreport_feed_info.yaml.example** to **stockreport_feed_info.yaml**. Open stockreport_feed_info.yaml in an editor.

On m2x.att.com, click your name in the upper-right hand corner, and click the "Master Keys" tab. Copy the Master Key value, and paste it into stockreport_feed_info.yaml.

stockreport.py should now be reporting the price of AT&T's stock to AT&T M2X every five minutes. (Please note that the NYSE is open from 9:30 AM to 4 PM Eastern Time, and the stock price reported will not change outside those hours.)

If there's any errors from stockreport.py, they will be logged in stockreport.log in your repo directory.
