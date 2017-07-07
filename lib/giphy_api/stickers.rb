module GiphyAPI
  class Stickers
    class << self
      def search keyword, options = {}
        get('/search', options.merge(q: keyword))
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

      private

      def path_prefix
        '/stickers'
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
