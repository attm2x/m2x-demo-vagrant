#!/usr/bin/env python

import os
import time

import datetime

import ystockquote

from m2x.client import M2XClient

TIMEFORMAT = "%Y-%m-%d %H:%M:%S"
print("%s: Starting stockreport.py run" % time.strftime(TIMEFORMAT))

DEVICE_NAME = "stockreport-heroku"

# Load config
APIKEY = open(os.environ['OPENSHIFT_REPO_DIR'] + 'm2x_api_key.txt').read().strip()
now = datetime.datetime.now()
ATT_Stock_Price = ystockquote.get_price('T')

# Now let's create a device:
client = M2XClient(key=APIKEY)
stockreport_device_exists = False
for device in client.devices:
    if device.name == DEVICE_NAME:
        stockreport_device_exists = True
        break

if not stockreport_device_exists:
    device = client.devices.create(
        name=DEVICE_NAME,
        description="Stockreport Example Device",
        visibility="private")

# Now we need to get the stream for AT&T's stock ticker symbol ("T")
ATT_Stream_Exists = False
for stream in device.streams:
    if stream.name.upper() == "T":
        ATT_Stream_Exists = True
        break

if not ATT_Stream_Exists:
    stream = device.streams.create('T')

stream.update(unit={'label': 'Dollars', 'symbol': '$'})

stream.values.add_value(ATT_STOCK_PRICE, now)

print("Ending stockreport.py run")
print
