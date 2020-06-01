require 'pry'
require 'bigdecimal'
require 'bigdecimal/util'
require_relative '../node'
require_relative '../vehicle'
require_relative 'heuristic'
require_relative 'wrong_type_error'
require_relative 'services/matrix_parser'
require_relative 'services/matrix_maker'

module VRP
  class FileSetter
    attr_accessor :lines, :type, :clients, :nodes, :vehicle, :matrix

    def initialize(**attrs)
      @lines = attrs[:lines]
      @type = attrs[:type]
      @nodes = [Node.new(demand: 0, deposit: true, id: 0)]

      parse_file unless attrs_absent?
    end

    private

    def parse_file
      get_clients_count

      set_vehicle

      nodes.push(*create_nodes)

      case type
      when 'matrix'
        parse_matrix_file
      when 'coordinates'
        parse_coordinates_file
      else
        raise VRP::WrongTypeError
      end
    end

    def set_vehicle
      self.vehicle = Vehicle.new(capacity: lines[2].delete('VehCapacity: ').to_i)
    end

    def create_nodes
      lines[4].split(',').map(&:to_i).map.with_index do |client_demand, index|
        Node.new(demand: client_demand, deposit: false, id: index + 1)
      end
    end

    def get_clients_count
      self.clients = lines.first.delete('nbClients: ').to_i
    end

    def parse_matrix_file
      self.matrix = VRP::Services::MatrixParser.new(lines[8..-1]).call
    end

    def parse_coordinates_file
      self.matrix = VRP::Services::MatrixMaker.new(lines[8..-1]).call
    end

    def attrs_absent?
      lines.nil? || type.nil?
    end
  end
end
