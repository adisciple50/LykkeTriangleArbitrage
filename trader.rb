require_relative 'lykke_private_api'
require 'time'
class Trader
  def initialize(trading,minimum_profit_per_trade,to_execute)
    if trading
      @private_api = LykkeRestApi::PrivateClient.new
      if to_execute.profit.to_f >= minimum_profit_per_trade
        order1 = @private_api.place_a_limit_order(to_execute.start.assetPairId,'buy',to_execute.start_quantity,to_execute.start.ask)
        puts "order 1 placed - #{to_execute.start.assetPairId}"
        unless @private_api.get_order_by_id(order1["payload"]["orderId"])  == 'Matched'
          wait_until_filled(order1)
        end
        puts "order 1 filled - - #{to_execute.start.assetPairId}"
        order2 = @private_api.place_a_limit_order(to_execute.middle.assetPairId,'sell',to_execute.middle_quantity,to_execute.middle.bid)
        puts "order 2 placed - #{to_execute.middle.assetPairId}"
        unless @private_api.get_order_by_id(order2["payload"]["orderId"]) == 'Matched'
          wait_until_filled(order2)
        end
        puts "order 2 filled - #{to_execute.middle.assetPairId}"
        order3 = @private_api.place_a_limit_order(to_execute.ending.assetPairId,'sell',to_execute.end_quantity,to_execute.ending.bid)
        puts "order 3 placed - #{to_execute.ending.assetPairId}"
        unless @private_api.get_order_by_id(order3["payload"]["orderId"]) == 'Matched'
          wait_until_filled(order3)
        end
        puts "order 3 filled - #{to_execute.ending.assetPairId}"
      end
      sleep 0.6
    end
  end
  def wait_until_filled(order)
    filled = @private_api.get_order_by_id(order["payload"]["orderId"])
    while filled != "Matched"
      filled = @private_api.get_order_by_id(order["payload"]["orderId"])
      puts filled["status"]
      sleep 0.6
    end

    sleep  0.6
  end
end