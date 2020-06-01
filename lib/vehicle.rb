require 'pry'

class Vehicle
  attr_accessor :capacity

  def initialize(**attrs)
    @capacity = attrs[:capacity]
  end
end