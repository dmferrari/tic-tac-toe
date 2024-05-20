#!/usr/bin/env ruby

# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/player'
require_relative '../lib/tic_tac_toe'

PLAYER1_TOKEN = 'X'
PLAYER2_TOKEN = 'O'

player1 = Player.new(name: 'Player 1', token: PLAYER1_TOKEN)
player2 = Player.new(name: 'Player 2', token: PLAYER2_TOKEN)
board = Board.new

TicTacToe.new(player1, player2, board).play
