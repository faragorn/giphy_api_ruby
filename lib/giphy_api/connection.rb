require 'uri'
require 'net/http'

module GiphyAPI
  class Connection
    URL = 'http://api.giphy.com'.freeze

    def initialize
      @site = URI.parse URL
    end

    def get path, options = {}
      request(:get, complete_path_with_query(path, options))
    end

    def request method, path, *arguments
      new_http.send method, path, *arguments
    end

    private

    def configuration
      GiphyAPI.configuration
    end

    def new_http
      Net::HTTP.new @site.host, @site.port
    end

    def complete_options options
      { api_key: configuration.api_key }.merge options
    end

    def complete_path path
      "/#{configuration.api_prefix}#{path}"
    end

    def complete_path_with_query path, query_options = {}
      encoded_options = URI.encode_www_form complete_options(query_options)
      "#{complete_path(path)}?#{encoded_options}"
    end
  end
end