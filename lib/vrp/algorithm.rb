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
    end
  end
end
