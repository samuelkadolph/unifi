require "uri"

module Unifi
  require "unifi/connection"
  require "unifi/site"

  class Controller
    attr_reader :connection, :endpoint, :password, :sites, :username

    def initialize(endpoint, username, password)
      self.endpoint = endpoint
      self.username = username
      self.password = password

      @sites = Site::Collection.new(self)

      set_connection
    end

    def endpoint=(value)
      @endpoint = value
      set_connection
    end

    def password=(value)
      @password = value
      set_connection
    end

    def username=(value)
      @username = value
      set_connection
    end

    private
    def set_connection
      @connection = Connection.new(endpoint, username, password)
    end
  end
end
