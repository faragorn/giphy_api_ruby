require 'test_helper'

class ConfigurationTest < GiphyAPI::Spec
  it "must set api_key to ENV['GIPHY_API_KEY'] on initialize" do
    with_temporary_env_value 'GIPHY_API_KEY', 'giphy_api_key_value' do
      GiphyAPI::Configuration.new.api_key.must_equal 'giphy_api_key_value'
    end
  end

  it 'must return new configuration if no configuration created' do
    GiphyAPI.configuration.must_be_instance_of GiphyAPI::Configuration
  end

  it 'must set configuration with a block' do
    with_temporary_value GiphyAPI.configuration, :api_key, 'temp_value' do
      GiphyAPI.configure do |config|
        config.api_key = 'giphy_api_key_through_configure'
      end
      GiphyAPI.configuration.api_key.must_equal 'giphy_api_key_through_configure'
    end
  end
end
