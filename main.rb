require 'pry'
require_relative 'lib/vrp/file_setter'
require_relative 'lib/vrp/heuristic'

file = File.expand_path('MT-DMP10s0-01.txt', 'test_instances')
file2 = File.expand_path('VRPNC1m.txt', 'test_instances')
file3 = File.expand_path('VRPNC5m.txt', 'test_instances')

heuristic1 = VRP::Heuristic.new(file: file, type: 'matrix', options: { algorithms: %w[Algorithm], times: 100 })
heuristic2 = VRP::Heuristic.new(file: file2, type: 'coordinates', options: { algorithms: %w[Algorithm], times: 100 })
heuristic3 = VRP::Heuristic.new(file: file3, type: 'coordinates', options: { algorithms: %w[Algorithm], times: 100 })
binding.pry

puts 'hi'
