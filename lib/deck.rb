# frozen_string_literal: true

class Deck
  attr_reader :cards
  SUITS = %w[diamons clubs hearts spades]
  RANKS = {6 => 6, 7 => 7, 8 => 8, 9 => 9, 10 => 10, 'J' => 2, 'Q' => 3, 'K' => 4 , 'A' => 11}

  def build_deck
    @cards = []
    SUITS.each do |suit|
      RANKS.each { |key,value| @cards << Card.new(suit, value, key) }
    end
    @cards.shuffle!
  end
end
