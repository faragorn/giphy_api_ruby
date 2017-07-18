module GiphyAPI
  class ConnectionError < StandardError
    attr_reader :response
    def initialize response, message = nil
      super(message)
      @response = response
    end

    def to_s
      msg = 'Failed.'
      msg << " Response code = #{response.code}." if response.respond_to?(:code)
      msg << " Reason = #{response.message}" if response.respond_to?(:message)
      msg
    end
  end

  class BadRequest < ConnectionError; end

  class UnauthorizedAccess < ConnectionError; end

  class ForbiddenAccess < ConnectionError; end

  class NotFound < ConnectionError; end

  class TooManyRequests < ConnectionError; end

  class ServerError < ConnectionError; end
end