#!/usr/bin/env ruby

require "m2x"
require "time"

TIMEFORMAT = "%Y-%m-%d %H:%M:%S"
DEVICE_NAME = "loadreport-heroku"

puts Time.now.strftime(TIMEFORMAT) + ": Starting loadreport.rb run"

APIKEY = ENV['M2X_API_KEY']

m2x = M2X::Client.new(APIKEY)

# Test to see if our device exists
loadreport_device_exists = false
devices = m2x.devices

lr_device = nil

devices.each { |d|
  if d.attributes["name"] == DEVICE_NAME
    loadreport_device_exists = true
    lr_device = d
  end
}

unless loadreport_device_exists
  puts "About to create the device..."
  lr_device = m2x.create_device(name: DEVICE_NAME, visibility: "private", description: "Load Report")
end

# Create the streams if they don't exist
lr_device.update_stream("load_1m",  {})
lr_device.update_stream("load_5m",  {})
lr_device.update_stream("load_15m", {})

# Get our load data from the system
# Match `uptime` load averages output for both Linux and OSX
UPTIME_RE = /(\d+\.\d+),? (\d+\.\d+),? (\d+\.\d+)$/
load_1m, load_5m, load_15m = `uptime`.match(UPTIME_RE).captures

# Write the different values into AT&T M2X
now = Time.now.iso8601

values = {
  values: {
    load_1m:  [ { value: load_1m, timestamp: now } ],
    load_5m:  [ { value: load_5m, timestamp: now } ],
    load_15m: [ { value: load_15m, timestamp: now } ]
  }
}

lr_device.post_updates(values)

puts "Ending loadreport.rb run"
puts
