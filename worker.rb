#!/usr/bin/env ruby
require 'rubygems'
require 'gearman'

#Gearman::Util.debug = true

worker = Gearman::Worker.new('localhost')
worker.reconnect_sec = 2

# upper ability
worker.add_ability('upper') do |data, job|
  puts data.upcase
end

# Running the workers
loop do
  worker.work
end
