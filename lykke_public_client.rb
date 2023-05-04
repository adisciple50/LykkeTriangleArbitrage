require 'httparty'
require_relative 'lykke_rest_api'
module LykkeRestApi
  ##
  # this class is the
  class PublicClient
    include HTTParty
    include LykkeRestApi
    base_uri 'https://hft-apiv2.lykke.com/api'

    ##
    # see lykke_rest_api.rb or README.MD for how to properly set up this bot

    headers {"Authorization" => "Bearer #{API_KEY}"}

    ##
    # get all currencies and assets

    def get_all_assets
      response = JSON.parse(self.class.get('/assets').body)
      structs = []
      response['payload'].map do |currency|
        asset = Struct.new(:assetId,:name,:symbol,:accuracy)
        structs << asset.new(currency['assetId'],currency['name'],currency['symbol'],currency['accuracy'])
      end
      return structs
    end

    ##
    # gets an asset by id

    def get_asset_by_id(asset_id)
      currency = JSON.parse(self.class.get("/assets/#{asset_id}").body)["payload"]
      asset = Struct.new(:assetId,:name,:symbol,:accuracy)
      return asset.new(currency['assetId'],currency['name'],currency['symbol'],currency['accuracy'])
    end
  end
  def get_all_asset_pairs
      response = JSON.parse(self.class.get('/assetpairs').body)
      structs = []
      response['payload'].map do |currency|
        asset = Struct.new(:assetPairId,
                           :symbol,
                           :baseAssetId,
                           :quoteAssetId,
                           :name,
                           :priceAccuracy,
                           :baseAssetAccuracy,
                           :quoteAssetAccuracy,
                           :minVolume,
                           :minOppositeVolume)
        structs << asset.new(currency['assetPairId'],
                             currency['baseAssetId'],
                             currency['priceAccuracy'],
                             currency['baseAssetAccuracy'],
                             currency['quoteAssetAccuracy'],
                             currency['minVolume'],
                             currency['minOppositeVolume']

        )
      end
      return structs
  end

  ##
  # Get a specific asset pair.

  def get_a_specific_pair(assetPairId)
    pair = JSON.parse(self.class.get("/assetpairs/{assetPairId}").body)
    asset = Struct.new(:assetPairId,
                         :symbol,
                         :baseAssetId,
                         :quoteAssetId,
                         :name,
                         :priceAccuracy,
                         :baseAssetAccuracy,
                         :quoteAssetAccuracy,
                         :minVolume,
                         :minOppositeVolume)
    return asset.new(pair['assetPairId'],
                           pair['baseAssetId'],
                           pair['priceAccuracy'],
                           pair['baseAssetAccuracy'],
                           pair['quoteAssetAccuracy'],
                           pair['minVolume'],
                           pair['minOppositeVolume']

    )
  end

  ##
  # Get the Order Book by asset pair. The order books contain a list of Buy(Bid) and Sell(Ask) orders with their corresponding price and volume.

  def asset_pair_order_book_ticker(assetPairId,depth=0)
    pair = JSON.parse(self.class.get("/orderbooks?assetPairId=#{assetPairId}&depth=#{depth}").body)['payload']
    asset = Struct.new(
      :assetPairId,
      :timestamp,
      :bids,
      :asks)
    return asset.new(
      pair['assetPairId'],
      pair['timestamp'],
      pair['bids'],
      pair['asks']
    )
  end

  ##
  # assetPairIds should be a an array of strings

  def twenty_four_hour_ticker_price_change_statistics(assetPairIds:Array)
    tickers = assetPairIds.map { |id| "assetPairIds=#{id.to_s}&"}.join.delete_suffix!('&')
    pair = JSON.parse(self.class.get("/tickers?#{tickers}").body)['payload']
    asset = Struct.new(
      :assetPairId,
      :volumeBase,
      :volumeQuote,
      :priceChange,
      :lastPrice,
      :high,
      :low,
      :timestamp,
    )
    return asset.new(
      pair['assetPairId'],
      pair['volumeBase'],
      pair['volumeQuote'],
      pair['priceChange'],
      pair['lastPrice'],
      pair['high'],
      pair['low'],
      pair['timestamp']
    )
  end
  def get_current_prices(assetPairId)
    assetPairIds = assetPairIds.map { |id| "assetPairIds=#{id.to_s}&"}.join.delete_suffix!('&')
    response = JSON.parse(self.class.get("/prices?#{assetPairIds}").body)['payload']
    response['payload'].map do |pair|
      asset = Struct.new(
        :assetPairId,
        :timestamp,
        :bids,
        :asks)
      return asset.new(
        pair['assetPairId'],
        pair['timestamp'],
        pair['bids'],
        pair['asks']
      )
    end
  end
  def get_public_trades(offset,take)
    assetPairIds = assetPairIds.map { |id| "assetPairIds=#{id.to_s}&"}.join.delete_suffix!('&')
    response = JSON.parse(self.class.get("/prices?#{assetPairIds}").body)['payload']
    response['payload'].map do |pair|
      asset = Struct.new(
        :assetPairId,
        :timestamp,
        :bid,
        :ask)
      return asset.new(
        pair['assetPairId'],
        pair['timestamp'],
        pair['bid'],
        pair['ask']
      )
    end
  end
end