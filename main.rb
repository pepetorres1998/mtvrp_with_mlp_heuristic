require 'pry'
require_relative 'lib/vrp/file_setter'

file = File.expand_path('MT-DMP10s0-01.txt', 'test_instances')
file2 = File.expand_path('VRPNC1m.txt', 'test_instances')

VRP::FileSetter.new(file: file, type: 'matrix')
VRP::FileSetter.new(file: file2, type: 'coordinates')

puts 'hi'
