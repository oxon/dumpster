module Dumpster
  module Model
    class Generic
      attr_accessor :types

      def initialize(data, types=[])
        @data = data
        @types = types
      end

      def each(&block)
        @data.each(&block)
      end
    end
  end
end
