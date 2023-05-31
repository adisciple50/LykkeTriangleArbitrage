require 'httparty'
require_relative 'lykke_rest_api'
module LykkeRestApi
  class PrivateClient
    include HTTParty
    include LykkeRestApi
    base_uri 'https://hft-apiv2.lykke.com/api'
    # header_struct = Struct.new{:Authorization,}
    headers 'Authorization' => "Bearer #{LykkeRestApi::API_KEY}",'Content-Type' => 'application/json'


    def place_a_limit_order(assetPairId,side,volume,price)
      request = self.class.post('/orders/limit',{body:{'assetPairId' => assetPairId.to_s, 'side' => side, 'volume' => volume.to_f, 'price' => price.to_f}})
      begin
        json = JSON.parse(request.body)
        puts json["error"]
        puts json
        return json
      rescue
        puts request.response
        exit
      end
    end
    def get_order_by_id(order_id)
    begin
      return JSON.parse(self.class.get("/orders/#{order_id.to_s}").body)
    rescue
      puts request.response
      exit
    end
    end
  end
end