module GiphyAPI
  class Configuration
    attr_accessor :api_key, :api_prefix, :json_parser

    def initialize
      self.api_key = ENV['GIPHY_API_KEY']
      self.api_prefix = 'v1'
      self.json_parser = ::JSON
    end
  end
end