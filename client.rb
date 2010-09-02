#!/usr/bin/env ruby
require 'rubygems'
require 'gearman'

#Gearman::Util.debug = true

servers = ['localhost:4730', 'localhost:4731']

client = Gearman::Client.new(servers)
taskset = Gearman::TaskSet.new(client)

('a'..'z').each do |letter|
  data = "#{letter} - #{Time.now.strftime('%M:%S')}"
  File.open('requests.txt', 'a') { |file| file.puts(data) }
  task = Gearman::Task.new('upper', data)
  task.on_complete do |d|
    File.open('responses.txt', 'a') { |file| file.puts(d) }
    puts d
  end
  taskset.add_task(task)
end
taskset.wait(100)
