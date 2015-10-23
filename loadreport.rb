#!/usr/bin/env ruby

require "m2x"
require "time"

DEVICE_NAME = "loadreport-vagrant-demo"
APIKEY      = File.read(File.expand_path("../m2x_api_key.txt", __FILE__)).strip

puts "Starting loadreport.rb at #{Time.now.iso8601}"

m2x = M2X::Client.new(APIKEY)

devices = m2x.devices

lr_device = devices.detect { |d| d["name"] == DEVICE_NAME }

unless lr_device
  puts "About to create the device..."
  lr_device = m2x.create_device(name: DEVICE_NAME, visibility: "private", description: "Load Report")
end

# Create the streams if they don't exist
lr_device.create_stream("load_1m")
lr_device.create_stream("load_5m")
lr_device.create_stream("load_15m")

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
