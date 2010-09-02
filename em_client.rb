#!/usr/bin/env ruby
require 'rubygems'
require 'gearman'

#Gearman::Util.debug = true

EM.run do
  Signal.trap(:INT) { EM.stop; puts 'yay - all done' }
  EM::PeriodicTimer.new(5) do
    client = Gearman::Client.new('localhost')
    taskset = Gearman::Taskset.new
    ('a'..'z').each do |letter|
      data = "#{letter} - #{Time.now.strftime('%M:%S')}"
      puts data
#      File.open('requests.txt', 'a') { |file| file.puts(data) }
      task = Gearman::Task.new('upper', data, :background => true)
#      task.on_complete do |d|
#        File.open('responses.txt', 'a') { |file| file.puts(d) }
#        puts d
#      end
      taskset.add_task(task)
    end
    client.run(taskset, 0, true)
  end
end
