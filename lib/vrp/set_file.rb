require 'pry'
require_relative '../node'
require_relative 'heuristic'

module VRP
  class SetFile
    attr_accessor :file, :type

    def initialize(**attrs)
      @file = attrs[:file]
      @type = attrs[:type]

      parse_file unless attrs_absent?
    end

    private

    def parse_file
      case type
      when 'matrix'
        parse_matrix_file
      when 'coordinates'
        parse_coordinates_file
      else
        raise WrongTypeError
      end
    end

    def attrs_absent?
      file.nil? || type.nil?
    end
  end
end
