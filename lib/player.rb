# frozen_string_literal: true

class Player
  attr_accessor :name, :cards, :score

  def initialize(name)
    @name = name
    @cards = []
    @score = 0
  end

  def take_card!(deck)
    @cards << deck.cards.shift
  end

  def count_score
    sum = 0
    cards.each { |card| sum += card.count_value }
    @score = sum
  end
end
