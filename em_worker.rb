#!/usr/bin/env ruby
require 'rubygems'
require 'gearman'

$stdout.sync = true

#Gearman::Util.debug = true


EM.run do
  worker = Gearman::Worker.new('localhost')

  worker.add_ability('upper') do |data, job|
    data.upcase!
    File.open('processed.txt', 'a') { |file| file.puts(data) }
    puts data
    data
  end

  worker.work
end

