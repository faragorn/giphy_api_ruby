module GiphyAPI
  class Configuration
    attr_accessor :api_key

    def initialize
      self.api_key = ENV['GIPHY_API_KEY']
    end
  end
end