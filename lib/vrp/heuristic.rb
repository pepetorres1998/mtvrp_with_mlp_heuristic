require 'pry'
require_relative 'file_setter'
require_relative 'delegator'

module VRP
  class Heuristic
    attr_accessor :clients, :nodes, :vehicle, :matrix, :options, :path

    def initialize(**attrs)
      file_setter = VRP::FileSetter.new(**attrs)

      @clients = file_setter.clients
      @nodes = file_setter.nodes
      @vehicle = file_setter.vehicle
      @matrix = file_setter.matrix
      @options = attrs[:options]

      start
    end

    def start
      self.path = VRP::Delegator.new({
                    nodes: nodes,
                    matrix: matrix,
                    vehicle: vehicle,
                    options: options
                  }).path
    end
  end
end
