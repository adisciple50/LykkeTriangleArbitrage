require_relative 'pair_factory'
require_relative 'chain'
class ChainFactory
  attr_reader :chains
  def initialize(stake_amount,stake_currency,resulting_currency=stake_currency,fiat_currencies=['EUR','USD','GBP'])
    @fiat_currencies = fiat_currencies
    @stake_amount = stake_amount
    @stake_currency = stake_currency
    @resulting_currency = resulting_currency
    @start_and_end_are_the_same = @stake_currency != @resulting_currency
    @pair_factory = PairFactory.new
    @pairs = @pair_factory.pairs
    @starts = get_starting_pairs
    @ends = get_ending_pairs
    @intermediates = get_intermediate_pairs
    @chains = assemble_chains
  end
  def get_starting_pairs
    @pairs.filter {|asset| asset.quoteAssetId == @stake_currency}
  end
  def get_ending_pairs
    @pairs.filter {|asset| asset.quoteAssetId == @resulting_currency}
  end
  def get_intermediate_pairs
    @pairs.filter do |pair|
      @starts.map {|start| get_base_and_quote_s(start)[0]}.include?(get_base_and_quote_s(pair)[0]) && @ends.map {|end_to_parse| get_base_and_quote_s(end_to_parse)[0]}.include?(get_base_and_quote_s(pair)[1])
    end.filter {|blacklist| @fiat_currencies.include?(blacklist.quoteAssetId) == false}
  end

  def get_base_and_quote_s(asset)
    asset.name.split('/')
  end

  def assemble_chains
    to_return = []
    @starts.each do |start|
      puts "start is #{get_base_and_quote_s(start)}"
      @intermediates.filter {|middle_to_parse| middle_to_parse.baseAssetId == start.baseAssetId}.filter {|blacklist| @fiat_currencies.include?(get_base_and_quote_s(blacklist)[0]) == false}.each do |middle|
        @ends.filter{|end_to_parse| get_base_and_quote_s(end_to_parse)[0] == get_base_and_quote_s(middle)[1]}.each do |ending|
          puts "middle is: #{get_base_and_quote_s(middle)}"
          # ending = @ends.filter {|ending_to_parse| get_base_and_quote_s(ending_to_parse)[0] == get_base_and_quote_s(middle_to_parse)[1]}[0]
          puts "ending: #{get_base_and_quote_s(ending)}"
          if start && middle && ending
            to_return << Chain.new(start,middle,ending,@stake_amount.to_f,@start_and_end_are_the_same)
          end
        end
      end
    end
    return to_return
  end
end