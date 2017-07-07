require 'giphy_api/version'
require 'json'
require 'giphy_api/configuration'
require 'giphy_api/exceptions'
require 'giphy_api/connection'
require 'giphy_api/gifs'


module GiphyAPI
  class <<  self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end
    def configure &block
      yield configuration
    end
  end
end
