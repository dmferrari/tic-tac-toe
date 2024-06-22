# frozen_string_literal: true

require_relative '../../lib/board'
require_relative '../../lib/player'
require_relative '../../lib/tic_tac_toe'

RSpec.describe TicTacToe do
  let(:player1) { instance_double(Player, name: 'Player 1', token: 'X', identifier: 'Player 1 (X)') }
  let(:player2) { instance_double(Player, name: 'Player 2', token: 'O', identifier: 'Player 2 (0)') }
  let(:player3) { instance_double(Player, name: 'Player 3', token: '@', identifier: 'Player 3 (@)') }
  let(:player4) { instance_double(Player, name: 'Player 4', token: '#', identifier: 'Player 4 (#)') }
  let(:players) { [player1, player2, player3, player4] }
  let(:board) { instance_double(Board) }

  subject(:game) { described_class.new(board, players) }

  describe '#initialize' do
    context 'when initialized' do
      it 'assigns current player to player1' do
        expect(game.instance_variable_get(:@current_player)).to eq(player1)
      end
    end
  end

  describe '#play' do
    pending 'Awaiting implementation'
  end
end
