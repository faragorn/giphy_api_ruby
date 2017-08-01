require 'giphy_api/version'
require 'json'
require 'giphy_api/configuration'
require 'giphy_api/exceptions'
require 'giphy_api/connection'
require 'giphy_api/collection'
require 'giphy_api/raw_data_attributes'
require 'giphy_api/resources'

module GiphyAPI
  class <<  self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end
    def configure
      yield configuration
    end
  end
end
