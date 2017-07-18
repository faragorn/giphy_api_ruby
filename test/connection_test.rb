require 'test_helper'
module GiphyAPI
  class ConnectionTest < Spec
    let(:subject) { GiphyAPI::Connection.new }
    describe 'complete_path' do
      it 'must return path with default api_prefix' do
        with_temporary_value(GiphyAPI.configuration, :api_prefix, 'prefix') do 
          subject.send(:complete_path, '/uri').must_equal '/prefix/uri'
        end
      end
    end

    describe 'complete_options' do
      it 'must include api_key key' do
        subject.send(:complete_options).must_include :api_key
      end
      it 'must return configured value for api_key' do
        with_temporary_value(GiphyAPI.configuration, :api_key, 'key') do
          subject.send(:complete_options).fetch(:api_key).must_equal 'key'
        end
      end
      it 'must persist passed options' do
        subject.send(:complete_options, some_key: :value).fetch(:some_key).must_equal :value
      end
    end

    describe 'complete_path_with_query' do
      it 'must generate a valid url-encoded request uri' do
        with_temporary_value(GiphyAPI.configuration, :api_key, 'key') do
          subject.send(:complete_path_with_query, '/path', parameter1: :value).must_equal '/v1/path?parameter1=value&api_key=key'
        end
      end
    end

    describe 'handle_response' do
      it 'must raise BadRequest if 400 response is returned' do
        -> { subject.send(:handle_response, fake_response('', 'Bad Request', 400)) }.must_raise BadRequest
      end
      it 'must raise UnauthorizedAccess if 401 response is returned' do
        -> { subject.send(:handle_response, fake_response('', 'Unauthorized', 401)) }.must_raise UnauthorizedAccess
      end
      it 'must raise ForbiddenAccess if 403 response is returned' do
        -> { subject.send(:handle_response, fake_response('', 'Forbidden', 403)) }.must_raise ForbiddenAccess
      end
      it 'must raise NotFound if 404 response is returned' do
        -> { subject.send(:handle_response, fake_response('', 'Not Found', 404)) }.must_raise NotFound
      end
      it 'must raise TooManyRequests if 429 response is returned' do
        -> { subject.send(:handle_response, fake_response('', 'Too Many Requests', 429)) }.must_raise TooManyRequests
      end
      it 'must raise ServerError if 500 response is returned' do
        -> { subject.send(:handle_response, fake_response('', 'Bad Request', 500)) }.must_raise ServerError
      end
      it 'must raise ConnectionError for unexpected response is returned' do
        -> { subject.send(:handle_response, fake_response('', 'Bad Request', 303)) }.must_raise ConnectionError
      end
    end
  end
end
