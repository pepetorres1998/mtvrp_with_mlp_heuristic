require 'pry'

class Node
  attr_accessor :id, :demand, :deposit

  def initialize(**attrs)
    @id = attrs[:id]
    @demand = attrs[:demand]
    @deposit = attrs[:deposit]
  end
end
