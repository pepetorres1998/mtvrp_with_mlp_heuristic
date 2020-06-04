require 'pry'
require_relative '../route'
require_relative '../path'

module VRP
  class Algorithm
    attr_accessor :nodes, :matrix, :vehicle, :path

    def initialize(**attrs)
      @nodes = attrs[:nodes]
      @matrix = attrs[:matrix]
      @vehicle = attrs[:vehicle]

      start
    end

    def start
      make_path

      until nodes.reject(&:deposit).empty?
        route = Route.new(deposit: nodes[0], vehicle: vehicle, matrix: matrix)

        nodes_that_fit = nodes_fit_in route
        from = route.path.last.id
        distances = nodes_that_fit.map { |node| matrix[from][node.id] }
        min_value = distances.min
        min_value_position = distances.index(min_value)
        first_node = nodes_that_fit[min_value_position]
        route.add_node(first_node)
        nodes.delete(first_node)

        nodes_that_fit = nodes_fit_in route

        until nodes_that_fit.empty?
          paths_for_k_nodes = convert_to_tuples route.path

          k_nodes = nodes_that_fit.map(&:id).map do |k_node|
            paths_for_k_nodes.map do |path|
              {
                k_node: k_node,
                delta_f: matrix[path[0]][k_node] + \
                  matrix[k_node][path[1]] - \
                  matrix[path[0]][path[1]],
                path: [path[0], path[1]],
              }
            end
          end.flatten(1)

          selected_k_node = k_nodes.sort_by { |k_node| k_node[:delta_f] }.first(3).sample

          node_to_delete = nodes.find { |node| node.id == selected_k_node[:k_node] }

          selected_k_node[:k_node] = node_to_delete

          route.add_k_node(selected_k_node)

          nodes.delete(node_to_delete)

          nodes_that_fit = nodes_fit_in route
        end

        path.add_route(route)
      end
    end

    def make_path
      self.path = Path.new
    end

    private

    def convert_to_tuples(current_path)
      current_path.map.with_index do |node, index|
        [node.id, current_path[index + 1].id] unless index == current_path.count - 1
      end.reject(&:nil?)
    end

    def nodes_fit_in(route)
      nodes.select { |node| node.demand <= route.available_capacity && !node.deposit }
    end
  end
end
