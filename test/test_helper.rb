require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
end

if ENV['CI']
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'giphy_api_ruby'
require 'minitest/autorun'
require 'byebug'
require 'fake_web'

FakeWeb.allow_net_connect = %r[^https?://codecov.io]

module GiphyAPI
  class Spec < Minitest::Spec
    def with_temporary_value object, method_name, value, &block
      old_value = object.send(method_name)
      object.send("#{method_name}=", value)
      yield
    ensure
      object.send("#{method_name}=", old_value)
    end

    def with_temporary_env_value key, value, &block
      old_value = ENV[key]
      ENV[key] = value
      yield
    ensure
      ENV[key] = old_value
    end

    def load_fixture name, format = :json
      File.read(File.dirname(__FILE__) + "/fixtures/#{name}.#{format}")
    end

    def fake_response body, message, code
      response = Net::HTTPResponse.new('1.0', code.to_s, message)
      response.instance_variable_set(:@body, body)
      response.instance_variable_set(:@read, true)
      response
    end

    def fake_request endpoint, method: :get, fixture:, **options
      url = [Connection::SITE, GiphyAPI.configuration.api_prefix, endpoint].join('/')
      body = load_fixture(fixture)
      FakeWeb.register_uri(method, url, {:body => body, :status => 200, :content_type => "text/json"}.merge(options))
    end
  end
end

