module Dumpster
  module Model
    class ActiveRecordSql
      attr_accessor :types

      def initialize(sql, connection = ActiveRecord::Base.connection, types=[])
        @sql = sql
        @connection = connection
        @types = types
      end

      def each(&block)
        @connection.select_rows(@sql).each(&block)
      end

    end
  end
end
