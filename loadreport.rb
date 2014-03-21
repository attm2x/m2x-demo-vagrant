#!/usr/bin/env ruby

require "m2x"
require "yaml"
TIMEFORMAT = "%Y-%m-%d %H:%M:%S"

puts Time.now.strftime(TIMEFORMAT) + " Starting loadreport.rb run"


feedinfo = YAML.load_file('/vagrant/feed_info.yaml')
API_KEY = feedinfo["apikey"]
FEED = feedinfo["feedid"]


m2x = M2X.new(API_KEY)

# Match `uptime` load averages output for both Linux and OSX
UPTIME_RE = /(\d+\.\d+),? (\d+\.\d+),? (\d+\.\d+)$/

load_1m, load_5m, load_15m = `uptime`.match(UPTIME_RE).captures

# Write the different values into AT&T M2X
m2x.feeds.update_stream(FEED, "load_1m",  value: load_1m)
m2x.feeds.update_stream(FEED, "load_5m",  value: load_5m)
m2x.feeds.update_stream(FEED, "load_15m", value: load_15m)

puts Time.now.strftime(TIMEFORMAT) + " Ending loadreport.rb run"
puts
