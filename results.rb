require_relative 'chain_factory'
class Results
  attr_reader :winner
  def initialize(stake_amount,stake_currency)
    @chains = ChainFactory.new(stake_amount,stake_currency)
    @chains = @chains.chains
    @winner = winner
  end
  def sorted_chains
    @chains.sort_by(&:profit)
  end
  def winner
    sorted_chains[-1]
  end
end