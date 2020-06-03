require_relative 'algorithm'
require_relative 'local_search'

module VRP
  class Delegator
    attr_accessor :nodes, :matrix, :vehicle, :options, :path

    def initialize(**attrs)
      @nodes = attrs[:nodes]
      @matrix = attrs[:matrix]
      @vehicle = attrs[:vehicle]
      @options = attrs[:options]

      execute_algorithms
    end

    def execute_algorithms
      options.each { |option| self.path = Object.const_get("VRP::#{option}").new(attributes) }
    end

    def attributes
      {
        nodes: nodes,
        vehicle: vehicle,
        matrix: matrix,
        path: path
      }
    end
  end
end
