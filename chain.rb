class Chain
  attr_reader :start
  attr_reader :middle
  attr_reader :ending
  attr_reader :profit
  attr_reader :start_quantity
  attr_reader :middle_quantity
  attr_reader :end_quantity
  def initialize(start,middle,ending,stake_amount,start_and_end_currencies_are_different = false)
    @start = start
    @middle = middle
    @ending = ending
    @stake_amount = stake_amount
    if start_and_end_currencies_are_different
      raise NotImplementedError
    end
    start_amount = @stake_amount / @start.ask.to_f
    @start_quantity = start_amount.truncate(@start.baseAssetAccuracy.to_i)
    @middle_quantity = @start_quantity * @middle.bid.to_f.truncate(@middle.quoteAssetAccuracy.to_i)
    @end_quantity = @middle_quantity * @ending.bid.to_f.truncate(@ending.quoteAssetAccuracy.to_i)
    @profit = profit
  end
  def profit
    profit = @start_quantity * @middle_quantity * @end_quantity
    profit.to_f.truncate(@ending.quoteAssetAccuracy.to_i) - @stake_amount
  end

  def to_s
    "#{@start.name} - #{@middle.name} - #{@ending.name} - profit: #{@profit}"
  end
end