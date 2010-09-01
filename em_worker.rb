#!/usr/bin/env ruby
require 'rubygems'
require 'gearman'

$stdout.sync = true

#Gearman::Util.debug = true


EM.run do
  worker = Gearman::Worker.new('localhost')

  # upper ability
  worker.add_ability('upper') do |data, job|
    puts "data = #{data}"
  #  puts "job = #{job.inspect}"
    data.upcase
  end

  # Running the workers
  worker.work
end

