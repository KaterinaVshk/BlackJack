# frozen_string_literal: true

require 'pry'
require 'io/console'

class Game
  MAX_POINT = 17
  attr_reader :deck, :user, :dealer, :game_over

  def initialize
    @deck = Deck.new.build_deck
    @user = Player.new('User')
    @dealer = Player.new('Dealer')
    @game_over = false
  end

  def start
    puts ' Welcome to Blackjack game!!!'.rjust(50)
    print "\n  Please enter your name: "
    name = $stdin.gets
    @user.name = name unless name == "\n"
    print '  Press any key to play'
    $stdin.getch
    play until @game_over
    puts "\n\n  GAME OVER. Thanks for playing!\n\n"
  end

  def play
    distribution_cards
    winner = determine_winner(@user.score, @dealer.count_score)
    show_cards(@dealer)
    print print_result(winner)
    status = one_more_round?
    @game_over = game_over?(status)
  end

  def distribution_cards
    puts "\n\n"
    puts 'New Round Start'.rjust(30)
    2.times { @user.take_card!(@deck) }
    2.times { @dealer.take_card!(@deck) }
    user_play(@deck)
    dealer_play(@deck) if @user.score <= 21
  end

  def user_play(deck)
    loop do
      score_user = @user.count_score
      show_cards(@user)
      break if score_user > 21

      status = continue?
      break if status != 'Y'

      @user.take_card!(deck)
    end
  end

  def continue?
    print "\n Would you like to take one more card? (Y/N) \n"
    $stdin.getch.upcase!
  end

  def dealer_play(deck)
    loop do
      @dealer.count_score
      break if @dealer.score >= MAX_POINT

      @dealer.take_card!(deck)
    end
  end

  def show_cards(player)
    puts "\n  Player cards: #{player.name}"
    player.cards.each(&:print)
    puts "  Score total = #{player.score}\n"
  end

  def determine_winner(user_score, dealer_score)
    return @dealer if user_score > 21
    return @user if dealer_score > 21
    return @user if user_score == 22 && user.cards.length == 2
    return @user if user_score > dealer_score
    return 0 if user_score == dealer_score

    @dealer
  end

  def calculate_result(winner)
    case winner
    when @user
      return "\n BLACKJACK !!!! WINNING!!!!".rjust(30) if @user.cards.length == 2 && @user.score == 21
      return "\n SUPER WINNER!!!!".rjust(30) if @user.score == 22

      'WINNING!!!'.rjust(30)
    when @dealer
      'LOSING!!!!'.rjust(30)
    when 0
      'DRAW!!!!'.rjust(30)
    end
  end

  def one_more_round?
    print "\n\n  Would you like to play another round? (Y/N)"
    $stdin.getch.upcase
  end

  def game_over?(answer)
    if answer == 'Y'
      @deck = Deck.new.build_deck
      @user.cards = []
      @dealer.cards = []
      false
    else
      true
    end
  end
end
