module ActsAsBookable
  module DBUtils
    class << self
      def connection
        ActsAsBookable::Booking.connection
      end

      def using_postgresql?
        connection && connection.adapter_name == 'PostgreSQL'
      end

      def using_mysql?
        #We should probably use regex for mysql to support prehistoric adapters
        connection && connection.adapter_name == 'Mysql2'
      end

      def using_sqlite?
        connection && connection.adapter_name == 'SQLite'
      end

      def active_record4?
        ::ActiveRecord::VERSION::MAJOR == 4
      end

      def active_record5?
        ::ActiveRecord::VERSION::MAJOR == 5
      end

      def like_operator
        using_postgresql? ? 'ILIKE' : 'LIKE'
      end

      # escape _ and % characters in strings, since these are wildcards in SQL.
      def escape_like(str)
        str.gsub(/[!%_]/) { |x| '!' + x }
      end
    end
  end
end