#!/usr/bin/env ruby
require 'rubygems'
require 'gearman'

Gearman::Util.debug = true

EM.run do
  EM::PeriodicTimer.new(5) do
    client = Gearman::Client.new('localhost')
    taskset = Gearman::Taskset.new
    ('a'..'z').each do |letter|
      task = Gearman::Task.new('upper', "#{letter} - #{Time.now.strftime('%M:%S')}")
      task.on_complete { |d| puts d }
      taskset.add_task(task)
    end
    client.run(taskset)
  end
end
