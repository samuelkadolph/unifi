module Unifi
  class Connection
    attr_accessor :password, :username
    attr_reader :endpoint

    def initialize(endpoint, username, password)
      self.endpoint = endpoint
      self.username = username
      self.password = password
    end

    def start
    end

    def started?
    end

    def finish
    end
  end
end
