module Unifi
  require "unifi/base"
  require "unifi/collection"

  class Sta < Base
    attr_accessor :_rx_bytes, :_rx_crypts, :_rx_dropped, :_rx_errors, :_rx_frags, :_rx_packets, :_tx_bytes, :_tx_dropped, :_tx_errors, :_tx_packets, :_tx_retries, :_uptime, :ap_mac, :assoc_time, :auth_time, :authorized, :bssid, :bytes, :bytes_d, :bytes_r, :ccq, :channel, :dhcpend_time, :dhcpstart_time, :essid, :first_seen, :hostname, :idletime, :ip, :is_11a, :is_11ac, :is_11b, :is_11n, :is_guest, :last_seen, :mac, :noise, :oui, :powersave_enabled, :qos_policy_applied, :radio, :roam_count, :rssi, :rx_bytes, :rx_bytes_d, :rx_bytes_r, :rx_crypts, :rx_crypts_d, :rx_crypts_r, :rx_dropped, :rx_dropped_d, :rx_dropped_r, :rx_errors, :rx_errors_d, :rx_errors_r, :rx_frags, :rx_frags_d, :rx_frags_r, :rx_mcast, :rx_packets, :rx_packets_d, :rx_packets_r, :rx_rate, :rx_retries, :signal, :site_id, :state, :state_ht, :state_pwrmgt, :tx_bytes, :tx_bytes_d, :tx_bytes_r, :tx_dropped, :tx_dropped_d, :tx_dropped_r, :tx_errors, :tx_errors_d, :tx_errors_r, :tx_packets, :tx_packets_d, :tx_packets_r, :tx_power, :tx_rate, :tx_retries, :tx_retries_d, :tx_retries_r, :uptime, :user_id

    class Collection < SiteCollection
      self.klass = Sta

      def find_all
        connection.get("/api/s/#{site.name}/stat/sta")
      end
    end
  end
end
