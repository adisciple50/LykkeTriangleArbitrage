require_relative 'results'
require_relative 'trader'
StakeCurrency = 'GBP'
StakeAmount = 40.00
Trading = true
MinimumProfitPerTrade = 0.05

trader = Trader.new(Trading,MinimumProfitPerTrade)

while true
  winner = Results.new(StakeAmount,StakeCurrency).winner
  puts winner
  # executes the winning trade sequence
  trader.trade_specified_chain(winner)
  sleep 0.6
end




