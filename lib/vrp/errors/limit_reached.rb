module VRP
  module Errors
    class LimitReached < StandardError
      def initialize(msg='Limit of capacity reached')
        super
      end
    end
  end
end
