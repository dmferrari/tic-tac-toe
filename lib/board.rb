# frozen_string_literal: true

class Board
  class CanNotAssignMove < StandardError; end

  EMPTY_CHAR = ' '

  attr_reader :board

  def initialize
    @board = Array.new(9, EMPTY_CHAR)
  end

  def display
    puts <<~BOARD

       #{@board[0]} | #{@board[1]} | #{@board[2]}
      ---+---+---
       #{@board[3]} | #{@board[4]} | #{@board[5]}
      ---+---+---
       #{@board[6]} | #{@board[7]} | #{@board[8]}

    BOARD
  end

  def valid_move?(position)
    (0..8).cover?(position) && @board[position] == EMPTY_CHAR
  end

  def assign_move(position, character)
    raise CanNotAssignMove, "Position: #{position}" unless valid_move?(position)

    @board[position] = character
  end

  def full?
    !@board.include?(EMPTY_CHAR)
  end

  def win?
    win_patterns.any? do |pattern|
      token = pattern[0]
      @board[token] != EMPTY_CHAR && pattern.all? { |index| @board[index] == @board[token] }
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
end
