module GiphyAPI
  class Configuration
    attr_accessor :api_key, :api_prefix

    def initialize
      self.api_key = ENV['GIPHY_API_KEY']
      self.api_prefix = 'v1'
    end
  end
end