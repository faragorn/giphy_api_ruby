require 'uri'
require 'net/http'

module GiphyAPI
  class Connection
    SITE = URI.parse('http://api.giphy.com').freeze

    def initialize
      @http = Net::HTTP.new SITE.host, SITE.port
    end

    def get path, options = {}
      request(:get, complete_path_with_query(path, options))
    end

    def request method, path, *arguments
      result = http.send method, path, *arguments
      handle_response(result)
    end

    private

    attr_reader :http

    def handle_response response
      case response.code.to_i
      when 200
        response
      when 400
        raise BadRequest.new(response, 'Request was formatted incorrectly or missing required parameters.')
      when 401
        raise UnauthorizedAccess.new(response, "Unauthorized to make this request. Missing API_KEY.")
      when 403
        raise ForbiddenAccess.new(response, "Unauthorized to make your request. Invalid API_KEY.")
      when 404
        raise NotFound.new(response, 'Gif or URL not found.')
      when 429
        raise TooManyRequests.new(response, 'Too many requests for your API_KEY.')
      when 500..600
        raise ServerError.new(response, 'Server Error')
      else
        raise ConnectionError.new(response)
      end
    end

    def configuration
      GiphyAPI.configuration
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