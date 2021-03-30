# frozen_string_literal: true

class Deck
  attr_reader :cards

  SUITS = %w[diamons clubs hearts spades].freeze
  RANKS = { 6 => 6, 7 => 7, 8 => 8, 9 => 9, 10 => 10, 'J' => 2, 'Q' => 3, 'K' => 4, 'A' => 11 }.freeze

  def build_deck
    @cards = []
    SUITS.each do |suit|
      RANKS.each { |rank, value| @cards << Card.new(suit, value, rank) }
    end
    @cards.shuffle!
  end
end
