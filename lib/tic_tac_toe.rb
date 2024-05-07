# frozen_string_literal: true

class TicTacToe
  def initialize(player1, player2, board)
    @board = board
    @player1 = player1
    @player2 = player2

    @current_player = @player1
  end

  def play
    @board.display

    loop do
      position = user_input
      @board.assign_move(position, @current_player.token)
      @board.display
      check_game_state
      switch_player
    end
  end

  private

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
    @current_player = @current_player == @player1 ? @player2 : @player1
  end
end
