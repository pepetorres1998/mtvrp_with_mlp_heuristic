require 'pry'
require_relative 'lib/vrp/file_setter'

lines = File.readlines('./test_instances/MT-DMP10s0-01.txt').map(&:strip).map { |line| line.gsub /\t/, ',' }
lines2 = File.readlines('./test_instances/VRPNC1m.txt').map(&:strip).map { |line| line.gsub /\t/, ',' }
VRP::FileSetter.new(lines: lines, type: 'matrix')
VRP::FileSetter.new(lines: lines2, type: 'coordinates')

puts 'hi'
