require 'httparty'
require_relative 'lykke_rest_api'
module LykkeRestApi
  class PrivateClient
    include HTTParty
    include LykkeRestApi
    base_uri 'https://hft-apiv2.lykke.com/api'
    headers {"Authorization" => "Bearer #{API_KEY}"}

    def place_a_limit_order(assetPairId,side,volume,price)
      request = self.class.post('/orders/limit',{body:{assetPairId: assetPairId,side: side,volume: volume.to_f,price:price.to_f}})
      begin
        return JSON.parse(request.body)
      rescue
        puts request.response
        exit
      end
    end
    def get_order_by_id(order_id)
      JSON.parse(self.class.get("/orders/#{order_id.to_s}").body)
    end
  end
end