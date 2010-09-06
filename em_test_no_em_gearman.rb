#!/usr/bin/env ruby
require 'rubygems'
require 'gearman'
require 'eventmachine'

$stdout.sync = true

#Signal.trap(:INT) { EM.stop; puts 'yay - all done' }
EM.initialize_event_machine
n = 0
EM::PeriodicTimer.new(1) do
  c = Gearman::Client.new('localhost')
  t = Gearman::TaskSet.new(c)
  if (n += 1) % 10 == 0
    print n
  else
    print '.'
  end
  task = Gearman::Task.new('upper', 'foo', :background => true)
  t.add_task(task)
  t.wait(0)
#    c.run(task)
#    c = nil
end
EM.run do
end
