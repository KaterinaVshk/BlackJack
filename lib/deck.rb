# frozen_string_literal: true

class Deck
  attr_reader :cards

  def initialize
    @cards = Deck.build_deck
  end

  def self.build_deck
    cards = []
    suits = %w[diamons clubs hearts spades]
    figures = %w[A K Q J]
    suits.each do |suit|
      (2..10).each { |number| cards << Card.new(suit, number) }
      figures.each { |figure| cards << Card.new(suit, figure) }
    end
    cards.shuffle!
  end
end
