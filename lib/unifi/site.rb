module Unifi
  require "unifi/base"
  require "unifi/collection"
  require "unifi/device"
  require "unifi/sta"

  class Site < Base
    attr_accessor :desc, :name
    attr_reader :devices, :stas

    class Collection < Collection
      self.klass = Site

      def all
        controller = self.controller

        super.each do |site|
          site.instance_exec do
            @devices = Device::Collection.new(controller, site)
            @stas = Sta::Collection.new(controller, site)
          end
        end
      end

      protected
      def find_all
        connection.post("/api/cmd/sitemgr", "json" => %Q{{"cmd":"get-sites"}})
      end
    end
  end
end
