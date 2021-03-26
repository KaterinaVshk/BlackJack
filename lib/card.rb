# frozen_string_literal: true

class Card
  FIGURES = %w[K Q J A].freeze
  attr_reader :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def count_value
    return 11 if @value == FIGURES[3]
    return 10 if FIGURES[0...-1].include?(@value)

    @value
  end

  def print
    puts '  _____'
    puts " | #{@value}  |" if @value == 10
    puts " | #{@value}   |" if FIGURES.include?(@value) || @value < 10
    puts " | \u2661   |" if @suit == 'hearts'
    puts " | \u2667   |" if @suit == 'clubs'
    puts " | \u2662   |" if @suit == 'diamons'
    puts " | \u2664   |" if @suit == 'spades'
    puts ' |_____| '
  end
end
