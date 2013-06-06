module Unifi
  require "unifi/base"
  require "unifi/collection"

  class Device < Base
    attr_accessor :_uptime, :adopted, :bytes, :bytes_d, :cfgversion, :config_network, :connect_request_ip,
                  :connect_request_port, :considered_lost_at, :device_id, :downlink_table, :ethernet_table, :guest_num_sta,
                  :guest_token, :inform_authkey, :inform_ip, :inform_url, :ip, :isolated, :known_cfgversion, :last_seen,
                  :locating, :locked, :mac, :map_id, :model, :na_channel, :na_eirp, :na_extchannel, :na_gain, :na_num_sta,
                  :na_state, :na_tx_power, :na_ast_be_xmit, :na_ast_cst, :na_ast_txto, :na_tx_packets, :na_tx_rates,
                  :na_tx_retries, :name, :next_heartbeat_at, :ng_channel, :ng_eirp, :ng_extchannel, :ng_gain, :ng_num_sta,
                  :ng_state, :ng_tx_power, :ng_ast_be_xmit, :ng_ast_cst, :ng_ast_txto, :ng_tx_packets, :ng_tx_rates,
                  :ng_tx_retries, :num_sta, :radio_na, :radio_ng, :radio_table, :rx_bytes, :rx_bytes_d, :scanning, :serial,
                  :site_id, :stat, :state, :tx_bytes, :tx_bytes_d, :type, :uplink, :uplink_table, :uptime, :user_num_sta,
                  :vap_table, :version, :vwireEnabled, :vwire_table, :wlangroup_id_na, :wlangroup_id_ng, :x, :x_authkey,
                  :x_fingerprint, :x_vwirekey, :y

    alias _uptime uptime

    class Collection < SiteCollection
      self.klass = Device

      def find_all
        connection.get("/api/s/#{site.name}/stat/device")
      end
    end
  end
end
