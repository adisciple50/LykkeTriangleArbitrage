class Chain
  attr_reader :start
  attr_reader :middle
  attr_reader :ending
  attr_reader :profit
  def initialize(start,middle,ending,stake_amount,start_and_end_currencies_are_different = false)
    @start = start
    @middle = middle
    @ending = ending
    @stake_amount = stake_amount
    if start_and_end_currencies_are_different
      raise NotImplementedError
    end
    @profit = profit
  end
  def profit
    one = @stake_amount / @start.ask.to_f
    profit = (one.truncate(@start.baseAssetAccuracy.to_i) * @middle.bid.to_f.truncate(@middle.quoteAssetAccuracy.to_i) * @ending.bid.to_f.truncate(@ending.quoteAssetAccuracy.to_i))
    profit.to_f.truncate(@ending.quoteAssetAccuracy.to_i) - @stake_amount
  end

  def to_s
    "#{@start.name} - #{@middle.name} - #{@ending.name} - profit: #{profit}"
  end
end