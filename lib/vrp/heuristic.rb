require 'pry'
require_relative 'file_setter'

module VRP
  class Heuristic
    attr_accessor :clients, :nodes, :vehicle, :matrix

    def initialize(**attrs)
      file_setter = VRP::FileSetter.new(**attrs)

      @clients = file_setter.clients
      @nodes = file_setter.nodes
      @vehicle = file_setter.vehicle
      @matrix = file_setter.matrix
    end
  end
end