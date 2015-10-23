#!/usr/bin/env python

import os
import time

import datetime

import ystockquote

from m2x.client import M2XClient

TIMEFORMAT = "%Y-%m-%d %H:%M:%S"
print("%s: Starting stockreport.py run" % time.strftime(TIMEFORMAT))

DEVICE_NAME = "stockreport-vagrant-demo"

# Load config
APIKEY = open('/vagrant/m2x_api_key.txt').read().strip()
now = datetime.datetime.now()
ATT_Stock_Price = ystockquote.get_price('T')

# Now let's create a device:
client = M2XClient(key=APIKEY)
stockreport_device_exists = False
for device in client.devices():
    if device.name == DEVICE_NAME:
        stockreport_device_exists = True
        break

if not stockreport_device_exists:
    device = client.create_device(
        name=DEVICE_NAME,
        description="Stockreport Example Device",
        visibility="private")

# Now we need to get the stream for AT&T's stock ticker symbol ("T")
ATT_Stream_Exists = False
for stream in device.streams():
    if stream.name.upper() == "T":
        ATT_Stream_Exists = True
        break

if not ATT_Stream_Exists:
    stream = device.create_stream('T')

stream.update(unit={'label': 'Dollars', 'symbol': '$'})

stream.add_value(ATT_Stock_Price, now)

print("Ending stockreport.py run")
print
