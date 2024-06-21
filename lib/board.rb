# frozen_string_literal: true

class Board
  require_relative 'colors'

  class CanNotAssignMove < StandardError; end

  EMPTY_CHAR = ' '
  TOKEN_COLORS = [Colors::BLUE, Colors::RED].freeze
  DEFAULT_COLOR = Colors::DARK_GRAY
  RESET_COLOR = Colors::RESET

  attr_reader :board

  def initialize
    @board = Array.new(9, EMPTY_CHAR)
    @players_tokens = []
  end

  def display
    puts <<~BOARD

       #{token_at(0)} | #{token_at(1)} | #{token_at(2)}
      ---+---+---
       #{token_at(3)} | #{token_at(4)} | #{token_at(5)}
      ---+---+---
       #{token_at(6)} | #{token_at(7)} | #{token_at(8)}

    BOARD
  end

  def valid_move?(position)
    (0..8).cover?(position) && @board[position] == EMPTY_CHAR
  end

  def assign_move(position, character)
    raise CanNotAssignMove, "Position: #{position}" unless valid_move?(position)

    @board[position] = character
    assign_players_tokens(character) if @players_tokens.size < 2
  end

  def full?
    !@board.include?(EMPTY_CHAR)
  end

  def win?
    win_patterns.any? do |pattern|
      token = pattern[0]
      board_token = @board[token]
      board_token != EMPTY_CHAR && pattern.all? { |index| @board[index] == board_token }
    end
  end

  private

  def win_patterns
    [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], # Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], # Columns
      [0, 4, 8], [2, 4, 6]             # Diagonals
    ]
  end

  def token_at(position)
    board_position = @board[position]
    token = board_position == EMPTY_CHAR ? (position + 1).to_s : board_position

    "#{token_color(token)}#{token}#{RESET_COLOR}"
  end

  def token_color(token)
    return DEFAULT_COLOR unless @players_tokens.include? token

    TOKEN_COLORS[@players_tokens.index(token)]
  end

  def assign_players_tokens(token)
    @players_tokens << token unless @players_tokens.include?(token)
  end
end
