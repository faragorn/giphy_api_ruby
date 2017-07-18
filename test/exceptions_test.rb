require 'test_helper'
module GiphyAPI
  class ExceptionsTest < Spec
    it 'to_s must generate a valid message' do
      error = ConnectionError.new(fake_response('', 'Bad Request', 400))
      error.to_s.must_equal 'Failed. Response code = 400. Reason = Bad Request'
    end
  end
end
