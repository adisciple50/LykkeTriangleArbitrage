require_relative 'results'
require_relative 'trader'
StakeCurrency = 'GBP'
StakeAmount = 40.00
Trading = false
MinimumProfitPerTrade = 0.05

trader = Trader.new(Trading,MinimumProfitPerTrade)

while true
  winner = Results.new(StakeAmount,StakeCurrency).winner
  puts winner
  # executes the winning trade sequence if Trading = true (see line 5)
  trader.trade_specified_chain(winner)
  sleep 0.6
end




