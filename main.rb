require 'pry'
require_relative 'lib/vrp/file_setter'
require_relative 'lib/vrp/heuristic'

file = File.expand_path('MT-DMP10s0-01.txt', 'test_instances')
file2 = File.expand_path('VRPNC1m.txt', 'test_instances')

VRP::Heuristic.new(file: file, type: 'matrix', options: %w[Algorithm]).start
VRP::Heuristic.new(file: file2, type: 'coordinates')

puts 'hi'
