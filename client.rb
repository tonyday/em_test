#!/usr/bin/env ruby
require 'rubygems'
require 'gearman'

#Gearman::Util.debug = true

servers = ['localhost:4730', 'localhost:4731']

client = Gearman::Client.new(servers)
taskset = Gearman::TaskSet.new(client)

('a'..'z').each do |letter|
  task = Gearman::Task.new('upper', letter)
#  task.on_complete { |d| puts d }
  taskset.add_task(task)
end
taskset.wait(100)
