module TradeFunctions
  def calculate_price(stage, bid_or_ask = :bid)
    puts "bid is"
    puts stage.bid
    puts "ask is"
    puts stage.ask
    puts "price accuracy is"
    puts stage.priceAccuracy
    price = 0.0
    if bid_or_ask == :bid
      price = stage.bid.to_f
    elsif bid_or_ask == :ask
      price = stage.ask.to_f
    end
    price = 1 / price
    # return price.to_f.truncate(stage.priceAccuracy.to_i)
    return price
  end
end
