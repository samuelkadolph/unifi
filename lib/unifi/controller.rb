require "uri"

module Unifi
  require "unifi/connection"
  require "unifi/device"
  require "unifi/sta"

  class Controller
    attr_reader :devices, :endpoint, :password, :stas, :username

    def initialize(endpoint, username, password)
      self.endpoint = endpoint
      self.username = username
      self.password = password

      set_connection
      @devices = DeviceCollection.new(self)
      @stas = StaCollection.new(self)
    end

    def endpoint=(value)
      value = URI(value) unless value.is_a?(URI::HTTP)
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
