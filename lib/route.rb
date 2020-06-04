require 'pry'
require_relative 'vrp/errors/limit_reached'

class Route
  attr_accessor :path, :deposit, :vehicle, :matrix

  def initialize(**attrs)
    @path = attrs[:path] ? attrs[:path] : [attrs[:deposit]]
    @matrix = attrs[:matrix]
    @deposit = attrs[:deposit]
    @vehicle = attrs[:vehicle]
  end

  def add_node(node)
    if limit_not_reached(node)
      self.path << node
    else
      raise VRP::Errors::LimitReached
    end
  end

  def final_path
    [path.map(&:id), deposit.id].flatten
  end

  def paths
    path.map.with_index do |from, to|
      if to != path.count - 1
        matrix[from.id][path[to + 1].id]
      else
        matrix[from.id][path[0].id]
      end
    end
  end

  def nodes_latencies(initial_amount = 0)
    total = []

    paths.each.with_index do |path, index|
      total << if index == 0
                 path + initial_amount
               else
                 path + total[index - 1]
               end
    end

    total
  end

  def latency
    nodes_latencies.sum
  end

  def demand
    path.map(&:demand).sum
  end

  def available_capacity
    vehicle.capacity - demand
  end

  private

  def limit_not_reached(node)
    node.demand + demand <= vehicle.capacity
  end
end
