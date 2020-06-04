require 'pry'
require_relative 'Route'

class Path
  attr_writer :routes

  def initialize(**attrs)
    @routes = attrs[:routes] ? attrs[:routes] : []
  end

  def routes
    @routes.sort_by(&:latency)
  end

  def final_path
    routes.map(&:final_path)
  end

  def add_route(route)
    @routes << route if route.is_a? Route
  end

  def nodes_latencies
    nodes_latencies = []
    routes.map.with_index do |route, index|
      nodes_latencies << if index.zero?
                           route.nodes_latencies
                         else
                           route.nodes_latencies(nodes_latencies[index - 1].last)
                         end
    end

    nodes_latencies
  end

  def latency
    nodes_latencies.flatten.sum
  end
end
