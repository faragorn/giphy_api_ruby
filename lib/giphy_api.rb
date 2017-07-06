require 'giphy_api/version'
require 'giphy_api/configuration'
require 'giphy_api/connection'

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
