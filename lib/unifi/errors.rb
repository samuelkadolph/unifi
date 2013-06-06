module Unifi
  class Error < StandardError
  end

  class HTTPError < Error
    attr_reader :body, :code, :http_message

    def initialize(response, message = nil)
      @body = response.body
      @code = response.code
      @http_message = response.message

      super(message || "#{code} #{http_message.dump}")
    end
  end

end
