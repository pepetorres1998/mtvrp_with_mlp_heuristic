require 'bigdecimal'
require 'bigdecimal/util'

module VRP::Services
  class MatrixParser
    attr_accessor :lines

    def initialize(lines)
      @lines = lines
    end

    def call
      lines.map { |line| line.split(',').map(&:to_d) }
    end
  end
end
