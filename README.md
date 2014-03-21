# M2X Vagrant Demo


## Introduction

This repo provides a Vagrant virtual machine that will report your load averages (how busy your virtual machine is) to M2X every minute. All the steps required to set this up are in bootstrap.bash, so if you want to replicate any part of this setup on your own systems, you can do so easily.

## Pre-Requisites

You will need to have [Vagrant](http://www.vagrantup.com/) and [VirtualBox](https://www.virtualbox.org/) installed on your computer. Both are free, and have versions for Mac OS X, Windows, and Linux.

You will also need an account on [m2x.att.com](https://m2x.att.com), which is currently free to everyone. (Future plans call for M2X to keep a free "Developer" plan, but to charge for very large volumes of data.)

## Installation
Clone the m2x-demo-vagrant repository (this one) to wherever you keep code on your computer.

```
git clone https://github.com/attm2x/m2x-demo-vagrant.git
```

Next, cd to the repo, and run "vagrant up":

```
cd m2x-demo-vagrant
vagrant up
```

This process should take between 2 and 10 minutes, depending on the speed of your computer and your network connection, and whether or not you've previously downloaded the "Precise64" Vagrant image.

While you're waiting, you may as well create the Data Source Blueprint you'll need.

## Creating a Data Source Blueprint

Log into [m2x.att.com](https://m2x.att.com) and create a Data Source Blueprint.

The Data Source Name should be "Vagrant Load" and the Data Source Description should be "System Load Averages". It should be a Private Data Source.


## Configuring the example application

Copy **loadreport_feed_info.yaml.example** to **loadreport_feed_info.yaml** and edit it to put in your API key and your Feed ID. Both are visible on the data source blueprint page on m2x.att.com.

You should now be sending data on 1-minute, 5-minute, and 15-minute load averages from your Vagrant virtual machine to AT&T M2X. It should be updating every minute, and if you refresh your AT&T M2X "Vagrant Load" Blueprint page, you should be able to click each load average and see graphs showing your load averages over time.

If not, you can look at loadreport.log in your repo, which records any errors in sending the data to M2X. You can also SSH to the Vagrant virtual machine with the ```vagrant ssh``` command.
