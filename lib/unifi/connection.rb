require "json"
require "net/http"

module Unifi
  require "unifi/errors"

  class Connection
    attr_accessor :password, :username
    attr_reader :endpoint

    def initialize(endpoint, username, password)
      self.endpoint = endpoint
      self.username = username
      self.password = password

      @cookies = {}
    end

    def endpoint=(value)
      value = URI(value) unless value.is_a?(URI::HTTP)
      @endpoint = value
    end

    def get(path, data = nil, headers = nil)
      request(:GET, path, data, headers)
    end

    def finish
      logout
      http.finish
      @started = nil
    end

    def post(path, data = nil, headers = nil)
      request(:POST, path, data, headers)
    end

    def start
      http.start
      login
      @started = true
    end

    def started?
      !!@started
    end

    protected
    def login
      response = http.post("/login", URI.encode_www_form(username: username, password: password, login: "Login"))
      raise HTTPError.new(response) unless response.code == "302"
      cookies(response)
      nil
    end

    def logout
      response = http.post("/logout")
      raise HTTPError.new(response) unless response.code == "302"
      cookies(response)
      nil
    end

    private
    def cookies(response = nil)
      if response && (cookies = response.get_fields("Set-Cookie"))
        cookies.each do |cookie|
          @cookies[$1] = $2 if cookie =~ /\A(\w+)=(\w+);?/
        end
      end

      @cookies.map { |k, v| "#{k}=#{v}" }.join("; ")
    end

    def http
      return @http if defined?(@http)

      http = Net::HTTP.new(endpoint.host, endpoint.port)
      http.ssl_version = :SSLv3
      http.use_ssl     = true if endpoint.is_a?(URI::HTTPS)
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      @http = http
    end

    def parse(response)
      case response["Content-Type"]
      when %r[\Aapplication/json]
        body = JSON.parse(response.body)

        if body["meta"] && body["meta"]["rc"] != "ok"
          raise HTTPError.new(response, body["meta"]["msg"])
        end

        body
      else
        raise HTTPError.new(response), "response was not json"
      end
    end

    def request(method, path, data = nil, headers = nil)
      start unless started?

      headers = { "Cookie" => cookies }.merge(headers || {})

      request = Net::HTTP.const_get(method.to_s.capitalize).new(path, headers)
      request.set_form_data(data) if data

      response = http.request(request)

      cookies(response)

      parse(response)
    end
  end
end
