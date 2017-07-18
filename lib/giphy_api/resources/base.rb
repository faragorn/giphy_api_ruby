module GiphyAPI
  class Base
    include RawDataAttributes
    class << self
      def find_with_scope path, scope, **options
        response = format.load get(path, options).body
        case scope
        when :all
          instantiate_collection(response['data'] || [], response['pagination'] || {})
        when :one
          instantiate_record(response['data'] || {})
        end
      end

      private

      def get path, **options
        connection.get(path_with_prefix(path), options)
      end

      def instantiate_collection collection, pagination
        Collection.new(collection).tap do |c|
          c.total_count = pagination['total_count']
          c.offset = pagination['offset']
        end.collect! { |record| instantiate_record(record) }
      end

      def instantiate_record record
        new(record)
      end

      def format
        GiphyAPI.configuration.json_parser
      end

      def path_prefix
        "/#{self.name.split('::').last.downcase}s"
      end

      def path_with_prefix path
        "#{path_prefix}#{path}"
      end

      def connection
        GiphyAPI::Connection.new
      end
    end

    def initialize attributes = {}
      assign_raw_data(attributes)
    end
  end
end