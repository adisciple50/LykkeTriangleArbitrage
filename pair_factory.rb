require_relative 'lykke_public_client'
class PairFactory
  attr_reader :pair_prices
  attr_reader :pair_details
  attr_reader :pairs
  def initialize
    @public_client = LykkeRestApi::PublicClient.new
    @pair_prices = get_all_asset_prices
    @pair_details = @public_client.get_all_asset_pairs
    @pairs = merge_pair_details
  end
  def get_asset_ids
    @public_client.get_all_asset_pairs.map { |pair| pair.assetPairId }
  end
  def get_all_asset_prices
    @public_client.get_current_prices(get_asset_ids)
  end
  def merge_pair_details
    asset = Struct.new(:assetPairId,
                       :symbol,
                       :baseAssetId,
                       :quoteAssetId,
                       :name,
                       :priceAccuracy,
                       :baseAssetAccuracy,
                       :quoteAssetAccuracy,
                       :minVolume,
                       :minOppositeVolume,
                       # prices section
                       :timestamp,
                       :bid,
                       :ask)
    assets = []
    @pair_prices.map do |pair|
      pair_name = pair.assetPairId
      details = @pair_details.filter {|details| details.assetPairId == pair_name}[0]
      struct = asset.new
      struct.assetPairId = pair_name
      struct.symbol = details.symbol
      struct.baseAssetId = details.baseAssetId
      struct.quoteAssetId = details.quoteAssetId
      struct.name = details.name
      struct.priceAccuracy = details.priceAccuracy
      struct.baseAssetAccuracy = details.baseAssetAccuracy
      struct.quoteAssetAccuracy = details.quoteAssetAccuracy
      struct.minVolume = details.minVolume
      struct.minOppositeVolume = details.minOppositeVolume
      # prices
      struct.timestamp = pair.timestamp
      struct.bid = pair.bid
      struct.ask = pair.ask
      assets << struct
    end
    return assets
  end
end