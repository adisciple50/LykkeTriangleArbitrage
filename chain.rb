class Chain
  attr_reader :start
  attr_reader :middle
  attr_reader :ending
  attr_reader :profit
  attr_reader :profit_ratio
  def initialize(start,middle,ending,stake_amount,start_and_end_currencies_are_different = false)
    @start = start
    @middle = middle
    @ending = ending
    @stake_amount = stake_amount
    if start_and_end_currencies_are_different
      raise NotImplementedError
    end
    @profit = profit
    @profit_ratio = profit_ratio
  end
  def profit
    ((@stake_amount / @start.ask.to_f) * @middle.bid.to_f * @ending.bid.to_f) - @stake_amount
  end
  def profit_ratio
    ((@stake_amount / @start.ask.to_f) * @middle.bid.to_f * @ending.bid.to_f)
  end

  def to_s
    "#{@start.name} - #{@middle.name} - #{@ending.name} - profit: #{profit} - profit ratio: #{profit_ratio}"
  end
end