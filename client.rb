#!/usr/bin/env ruby
require 'rubygems'
require 'gearman'

Signal.trap(:INT) { puts 'setting @stopped'; @stopped = true }

#Gearman::Util.debug = true

servers = ['localhost:4730', 'localhost:4731']

client = Gearman::Client.new(servers)
taskset = Gearman::TaskSet.new(client)

while ! @stopped
  puts 'More ...'
  ('a'..'z').each do |letter|
    data = "#{letter} - #{Time.now.strftime('%M:%S')}"
    task = Gearman::Task.new('upper', data, :background => true)
    taskset.add_task(task)
  end
  taskset.wait(0)
  sleep 5 unless @stopped
end

puts 'All done - thanks for playing'
