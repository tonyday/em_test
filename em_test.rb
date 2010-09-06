#!/usr/bin/env ruby
require 'rubygems'
require 'gearman'

$stdout.sync = true

#Signal.trap(:INT) { EM.stop; puts 'yay - all done' }
n = 0
EM.run do
  EM::PeriodicTimer.new(0.05) do
    c = Gearman::Client.new('localhost')
    if (n += 1) % 10 == 0
      print n
    else
      print '.'
    end
    task = Gearman::Task.new('upper', n, :background => true)
    c.run(task)
  end
end
