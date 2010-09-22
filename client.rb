#!/usr/bin/env ruby
require 'rubygems'
require 'gearman'

client = Gearman::Client.new('localhost')
timestamp = Time.now.strftime('%Y%m%d%H%M%S')
(1..1000).each do |n|
  taskset = Gearman::TaskSet.new(client)
  data = "Hello, World - #{n}"
  uniq = "#{timestamp} - #{n}"
  task = Gearman::Task.new('upper', data, :background => true, :uniq => uniq)
  taskset.add_task(task)
  taskset.wait(0)
end
puts 'Done !'
