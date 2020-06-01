require 'pry'
require_relative 'lib/vrp/set_file'

lines = File.readlines('./test_instances/MT-DMP10s0-01.txt').map(&:strip).map { |line| line.gsub /\t/, ',' }
VRP::SetFile.new(lines: lines, type: 'matrix')

puts 'hi'