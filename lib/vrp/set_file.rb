require 'pry'
require_relative '../node'

module VRP
  class SetFile
    attr_accessor :file

    def initialize(**attrs)
      @file = attrs[:file]

      start_heuristic if attrs_present?
    end

    private

    def attrs_present?
      file.present?
    end
  end
end
