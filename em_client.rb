# Test change to see how pull requests work
#!/usr/bin/env ruby
require 'rubygems'
require 'gearman'

Signal.trap(:INT) { puts 'setting @stopped'; @stopped = true }

client = Gearman::Client.new('localhost:4730')

n = 0
EM.run do
#  EM::PeriodicTimer.new(0.05) do
  while ! @stopped do
    n += 1
    data = sprintf("%07d - %s\n", n, Time.now.strftime('%M:%S'))
    puts data
    task = Gearman::Task.new('upper', data, :background => true)
    client.run(task, 0, true)
  end
  EM.stop
end
