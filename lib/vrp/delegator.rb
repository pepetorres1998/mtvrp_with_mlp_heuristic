require_relative 'algorithm'
require_relative 'local_search'
require_relative '../path'

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
      options[:times].times do
        options[:algorithms].each do |algorithm|
          save_path Object.const_get("VRP::#{algorithm}").new(attributes).path
        end
      end
    end

    def save_path(new_path)
      self.path = new_path if path.nil? || new_path.latency < path.latency
    end

    def attributes
      {
        nodes: nodes.clone,
        vehicle: vehicle,
        matrix: matrix,
        path: path
      }
    end
  end
end
