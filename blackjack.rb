# frozen_string_literal: true

$LOAD_PATH << './lib'
require 'deck'
require 'card'
require 'game'
require 'player'

puts
Game.new.start
