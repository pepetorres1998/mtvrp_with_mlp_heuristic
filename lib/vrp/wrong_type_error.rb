module VRP
  class WrongTypeError < StandardError
    def initialize(msg='Type defined does not exist')
      super
    end
  end
end