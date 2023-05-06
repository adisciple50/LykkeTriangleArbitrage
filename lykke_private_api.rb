require 'httparty'
require_relative 'lykke_rest_api'
module LykkeRestApi
  class PrivateApi
    include HTTParty
    include LykkeRestApi
    base_uri 'https://hft-apiv2.lykke.com/api'
    headers {"Authorization" => "Bearer #{API_KEY}"}

    def place_a_limit_order(assetPairId,side,volume,price)
      JSON.parse(self.class.post('/orders/limit',{body:{"assetPairId" => assetPairId,"side" => side,"volume" => volume,"price" => price}}).body)
    end
    def get_order_by_id(order_id)
      JSON.parse(self.class.get("/orders/#{order_id.to_s}").body)
    end
  end
end