#!/usr/bin/env ruby
require 'rubygems'
require 'gearman'

Signal.trap(:INT) { puts 'setting @stopped'; @stopped = true }

client = Gearman::Client.new('localhost')
taskset = Gearman::TaskSet.new(client)

n = 0
while !@stopped && n < 1000
  n += 1
  data = sprintf("%07d - %s", n, Time.now.strftime('%M:%S'))
  puts data
  task = Gearman::Task.new('upper', data, :background => true)
  taskset.add_task(task)
  taskset.wait(1_000_000)
  sleep 1 unless @stopped
end

puts 'All done - thanks for playing'
