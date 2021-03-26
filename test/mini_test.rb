# frozen_string_literal: true

$LOAD_PATH << '../lib'
require 'deck'
require 'card'
require 'game'
require 'player'
require 'rubygems'
require 'minitest/autorun'

class CardTest < Minitest::Test
  def test_initialize_raises_argument_exception
    assert_raises(ArgumentError) { Card.new('a', 'b', 'c') }
  end

  def test_count_value_jack
    test_card = Card.new('clubs', 'J')
    assert_equal(10, test_card.count_value)
  end

  def test_count_value_ace
    test_card = Card.new('clubs', 'A')
    assert_equal(11, test_card.count_value)
  end

  def test_number_count_value
    test_card = Card.new('clubs', 7)
    assert_equal(7, test_card.count_value)
  end
end

class DeckTest < Minitest::Test
  def test_initialize_raises_argument_exception
    assert_raises(ArgumentError) { Deck.new('a', 'b') }
  end

  def test_52_cards_build_deck
    deck = Deck.new
    assert_equal(52, deck.cards.length)
  end
end

class PlayerTest < Minitest::Test
  def setup
    @deck = Deck.new
    @player = Player.new('Player')
  end

  def test_initialize_raises_argument_exception
    assert_raises(ArgumentError) { Player.new('a', 'c') }
  end

  def test_player_take_card_and_deck_decreases
    @player.take_card!(@deck)
    assert_equal(1, @player.cards.length)
    assert_equal(51, @deck.cards.length)
  end

  def test_count_score_black_jack
    @player.cards[0] = Card.new('clubs', 'A')
    @player.cards[1] = Card.new('clubs', 10)
    assert_equal(21, @player.count_score)
  end
end

class GameTest < Minitest::Test
  def setup
    @game = Game.new
  end

  def test_initialize_raises_argument_exception
    assert_raises(ArgumentError) { Game.new('a') }
  end

  def test_dealer_play_with_21_score
    @game.dealer.cards[0] = Card.new('clubs', 'A')
    @game.dealer.cards[1] = Card.new('clubs', 10)
    @game.dealer_play(@game.deck)
    assert_equal(21, @game.dealer.score)
  end

  def test_dealer_play_with_17_score
    @game.dealer.cards[0] = Card.new('clubs', 7)
    @game.dealer.cards[1] = Card.new('clubs', 10)
    @game.dealer_play(@game.deck)
    assert_equal(17, @game.dealer.score)
  end

  def test_dealer_play_with_16_score
    @game.dealer.cards[0] = Card.new('clubs', 6)
    @game.dealer.cards[1] = Card.new('clubs', 10)
    @game.dealer_play(@game.deck)
    assert_operator @game.dealer.score, :>=, 17
  end

  def test_user_has_more_than_21
    @game.user.score = 22
    assert_equal(@game.dealer, @game.determine_winner(@game.user.score, 18))
  end

  def test_dealer_has_more_than_21
    @game.dealer.score = 22
    assert_equal(@game.user, @game.determine_winner(17, @game.dealer.score))
  end

  def test_dealer_and_user_have_more_than_21
    @game.dealer.score = 32
    @game.user.score = 22
    assert_equal(@game.dealer, @game.determine_winner(@game.user.score, @game.dealer.score))
  end

  def test_user_win_dealer_with_less_than_21
    @game.dealer.score = 17
    @game.user.score = 18
    assert_equal(@game.user, @game.determine_winner(@game.user.score, @game.dealer.score))
  end

  def test_draw_between_user_and_dealer
    @game.dealer.score = 17
    @game.user.score = 17
    assert_equal(0, @game.determine_winner(@game.user.score, @game.dealer.score))
  end

  def test_dealer_win_user_with_less_than_21
    @game.dealer.score = 17
    @game.user.score = 16
    assert_equal(@game.dealer, @game.determine_winner(@game.user.score, @game.dealer.score))
  end

  def test_one_more_round
    assert_equal(false, @game.game_over?('Y'))
  end

  def test_game_over
    assert_equal(true, @game.game_over?('N'))
  end

  def test_print_result_if_user_win
    @game.user.score = 15
    assert_equal 'WINNING!!!'.rjust(30), @game.print_result(@game.user)
  end

  def test_print_result_if_dealer_win
    assert_equal 'LOSING!!!!'.rjust(30), @game.print_result(@game.dealer)
  end

  def test_print_result_if_draw
    assert_equal 'DRAW!!!!'.rjust(30), @game.print_result(0)
  end

  def test_print_result_if_blackjack
    @game.user.score = 21
    2.times { @game.user.cards << Card.new('clubs', 6) }
    assert_equal "\n У вас блэкджэк !!!! WINNING!!!!".rjust(30), @game.print_result(@game.user)
  end
end
