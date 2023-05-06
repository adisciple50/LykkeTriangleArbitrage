require_relative 'results'
# could be
StakeCurrency = 'GBP'
StakeAmount = 50.00

puts Results.new(StakeAmount,StakeCurrency).winner


