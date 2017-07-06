require 'test_helper'

class ConfigurationTest < Minitest::Spec
  it "must set api_key to ENV['GIPHY_API_KEY'] on initialize" do
    cached_giphy_api_key = ENV['GIPHY_API_KEY']
    ENV['GIPHY_API_KEY'] = 'giphy_api_key_value'
    GiphyAPI::Configuration.new.api_key.must_equal 'giphy_api_key_value'
    ENV['GIPHY_API_KEY'] = cached_giphy_api_key
  end
  it 'must return new configuration if no configuration created' do
    GiphyAPI.configuration.must_be_instance_of GiphyAPI::Configuration
  end
  it 'must set configuration with a block' do
    GiphyAPI.configure do |config|
      config.api_key = 'giphy_api_key_through_configure'
    end
    GiphyAPI.configuration.api_key.must_equal 'giphy_api_key_through_configure'
  end
end
