# frozen_string_literal: true

# TicTacToe represents the game logic for Tic Tac Toe.
class TicTacToe
  def initialize(first_player, second_player, board)
    @board = board
    @first_player = first_player
    @second_player = second_player

    @current_player = @first_player
  end

  def play
    display_board

    loop do
      position = user_input
      @board.assign_move(position, @current_player.token)
      display_board
      check_game_state
      switch_player
    end
  end

  private

  def display_board
    @board.display
  end

  def user_input
    loop do
      print "=> #{@current_player.identifier} your move [1-9]: "
      player_move = gets.chomp.to_i
      exit if player_move.zero?

      position = player_move - 1
      return position if @board.valid_move?(position)

      puts "=> #{player_move} is not a valid move. Try again."
    end
  end

  def check_game_state
    if @board.win?
      puts "=> #{@current_player.identifier} WINS!"
      exit
    elsif @board.full?
      puts '=> This is a draw!'
      exit
    end
  end

  def switch_player
    @current_player = @current_player == @first_player ? @second_player : @first_player
  end
end
