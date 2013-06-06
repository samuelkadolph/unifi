module Unifi
  class Collection
    class << self
      attr_accessor :klass
    end

    attr_reader :controller

    def initialize(controller)
      @controller = controller
    end

    def all
      hash = find_all
      hash ? parse_collection(hash) : nil
    end

    protected
    def parse_collection(hash)
      hash["data"].map(&method(:parse_one))
    end

    def parse_one(hash)
      object = klass.allocate
      hash.each do |name, value|
        object.public_send("#{name.tr("-", "_")}=", value)
      end
      object
    end

    def klass
      self.class.klass
    end

    private
    def connection
      controller.connection
    end
  end

  class SiteCollection < Collection
    attr_reader :site

    def initialize(controller, site)
      super(controller)
      @site = site
    end
  end
end
