module GiphyAPI
  class Gifs
    class << self
      def search keyword, options = {}
        get('/search', options)
      end

      def trending options = {}
        get('/trending', options)
      end

      def translate term, options = {}
        get('/translate', options.merge(s: term))
        # single object in data
      end

      def random options = {}
        # single object in data
        get('/random', options)
      end

      def find_by_id id, options = {}
        get("/#{id}", options)
        # single object in data
      end

      def find_by_ids *ids, **options
        byebug
        get('', options.merge(ids: ids.join(',')))
      end

      def get path, options = {}
        connection.get(path_with_prefix(path), options)
      end

      private

      def path_prefix
        '/gifs'
      end

      def path_with_prefix path
        "#{path_prefix}#{path}"
      end

      def connection
        @connection ||= GiphyAPI::Connection.new
      end
    end
  end
end
