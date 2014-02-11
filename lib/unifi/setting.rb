module Unifi
  require "unifi/base"
  require "unifi/collection"

  class Setting < Base
    attr_accessor :allowed_subnet_1, :auth, :authorize_use_sandbox, :auto_upgrade, :code, :community, :custom_ip, :discoverable, :enable_isolated_wlan, :enabled, :expire, :gateway, :host, :ip, :key, :led_enabled, :merchantwarrior_use_sandbox, :name, :payment_enabled, :paypal_use_sandbox, :port, :portal_customized, :portal_enabled, :portal_hostname, :portal_use_hostname, :redirect_enabled, :redirect_url, :restricted_subnet_1, :restricted_subnet_2, :restricted_subnet_3, :restricted_subnet_4, :sender, :show_tou, :site_id, :tou, :uplink_host, :uplink_type, :use_auth, :use_sender, :use_ssl, :username, :voucher_enabled, :x_authorize_loginid, :x_authorize_transactionkey, :x_merchantwarrior_apikey, :x_merchantwarrior_apipassphrase, :x_merchantwarrior_merchantuuid, :x_password, :x_paypal_password, :x_paypal_signature, :x_paypal_username, :x_quickpay_md5secret, :x_quickpay_merchantid, :x_ssh_password, :x_ssh_username, :x_stripe_api_key

    class Collection < SiteCollection
      self.klass = Setting

      def find_all
        connection.get("/api/s/#{site.name}/get/setting")
      end
    end
  end
end
