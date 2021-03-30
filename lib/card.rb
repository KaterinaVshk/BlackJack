# frozen_string_literal: true

class Card
  attr_accessor :suit, :value, :rank

  SUITS_MAP = { 'hearts' => "\u2661", 'clubs' => "\u2667", 'diamons' => "\u2662", 'spades' => "\u2664" }.freeze
  VALUES = { 6 => 6, 7 => 7, 8 => 8, 9 => 9, 10 => 10, 'J' => 2, 'Q' => 3, 'K' => 4, 'A' => 11 }.invert

  def initialize(suit, value, rank)
    @suit = suit
    @value = value
    @rank = rank
  end

  def print
    puts '  _____'
    puts " | #{VALUES[@value]}   |"
    puts " | #{SUITS_MAP[@suit]}   |"
    puts ' |_____| '
  end
end
