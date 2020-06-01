require 'bigdecimal'
require 'bigdecimal/util'

module VRP::Services
  class MatrixMaker
    attr_accessor :lines

    def initialize(lines)
      @lines = lines.map { |line| line.split(',').map(&:to_d) }
    end

    def call
      lines.map do |cord|
        lines.map do |inner_cord|
          Math.sqrt(((cord[0] - inner_cord[0]) ** 2) + ((cord[1] - inner_cord[1]) ** 2)).to_d
        end
      end
    end
  end
end
