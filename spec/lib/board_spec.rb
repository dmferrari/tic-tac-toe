# frozen_string_literal: true

require_relative '../../lib/board'

RSpec.describe Board do # rubocop:disable Metrics/BlockLength
  subject(:board) { described_class.new }

  shared_context 'without colors' do
    before do
      stub_const('Board::RESET_COLOR', '')
      stub_const('Board::DEFAULT_COLOR', '')
      stub_const('Board::TOKEN_COLORS', ['', ''])
    end
  end

  describe '#display' do # rubocop:disable Metrics/BlockLength
    include_context 'without colors'

    context 'when the board is not full' do
      before do
        board.instance_variable_set(:@board, [' ', ' ', 'X', 'O', ' ', ' ', 'X', ' ', 'X'])
      end

      it 'outputs the correct board layout to stdout' do
        expect { board.display }.to output(<<~BOARD).to_stdout

           1 | 2 | X
          ---+---+---
           O | 5 | 6
          ---+---+---
           X | 8 | X

        BOARD
      end
    end

    context 'when the board is full' do
      include_context 'without colors'

      before do
        board.instance_variable_set(:@board, %w[X O X O X O X O X])
      end

      it 'outputs the correct board layout to stdout' do
        expect { board.display }.to output(<<~BOARD).to_stdout

           X | O | X
          ---+---+---
           O | X | O
          ---+---+---
           X | O | X

        BOARD
      end
    end

    context 'token_colors' do # rubocop:disable Metrics/BlockLength
      # Capture the output of puts in a string
      before do
        @output = StringIO.new
        $stdout = @output
      end

      # Restore stdout
      after do
        $stdout = STDOUT
      end

      context 'player 1' do
        before do
          board.assign_move(0, 'X')
        end

        it 'shows the right color for player 1' do
          board.display
          expect(@output.string).to include(Board::TOKEN_COLORS[0])
        end
      end

      context 'player 2' do
        before do
          board.assign_move(0, 'X')
          board.assign_move(1, 'O')
        end

        it 'shows the right color for player 2' do
          board.display
          expect(@output.string).to include(Board::TOKEN_COLORS[1])
        end
      end
    end
  end

  describe '#valid_move?' do # rubocop:disable Metrics/BlockLength
    before do
      board.instance_variable_set(:@board, ['X', 'O', 'X', 'O', ' ', 'O', 'X', 'O', 'X'])
    end

    context 'when the position is inside the board' do
      let(:empty_position) { 4 }

      context 'when the position is empty' do
        it 'returns true' do
          expect(board.valid_move?(empty_position)).to be true
        end
      end

      context 'when the position is not empty' do
        let(:non_empty_position) { 0 }

        it 'returns false' do
          expect(board.valid_move?(non_empty_position)).to be false
        end
      end
    end

    context 'when the position is outside the board' do
      context 'when the position is below 1' do
        let(:invalid_move) { 0 }

        it 'returns false' do
          expect(board.valid_move?(invalid_move)).to be false
        end
      end

      context 'when the position is above 8' do
        let(:invalid_move) { 9 }

        it 'returns false' do
          expect(board.valid_move?(invalid_move)).to be false
        end
      end
    end
  end

  describe '#assign_move' do
    let(:character) { 'X' }

    before do
      board.instance_variable_set(:@board, ['X', 'O', 'X', 'O', ' ', 'O', 'X', 'O', 'X'])
    end

    context 'when the move is valid' do
      let(:position) { 4 }

      it 'assigns the move to the board' do
        expect do
          board.assign_move(position, character)
        end.to change { board.instance_variable_get(:@board)[position] }.from(' ').to(character)
      end
    end

    context 'when the move is invalid' do
      let(:position) { 9 }

      it 'raises an error' do
        expect do
          board.assign_move(position, character)
        end.to raise_error(Board::CanNotAssignMove, "Position: #{position}")
      end
    end
  end

  describe '#full?' do
    context 'when the board is full' do
      before do
        board.instance_variable_set(:@board, %w[X O X O X O X O X])
      end

      it 'returns true' do
        expect(board.full?).to be true
      end
    end

    context 'when the board is not full' do
      before do
        board.instance_variable_set(:@board, ['X', 'O', 'X', 'O', ' ', 'O', 'X', 'O', 'X'])
      end

      it 'returns false' do
        expect(board.full?).to be false
      end
    end
  end

  describe '#win?' do # rubocop:disable Metrics/BlockLength
    context 'when there is a winner' do # rubocop:disable Metrics/BlockLength
      let(:winner_boards) do # rubocop:disable Metrics/BlockLength
        [
          [
            'X', 'X', 'X',
            ' ', ' ', ' ',
            ' ', ' ', ' '
          ],
          [
            ' ', ' ', ' ',
            'X', 'X', 'X',
            ' ', ' ', ' '
          ],
          [
            ' ', ' ', ' ',
            ' ', ' ', ' ',
            'X', 'X', 'X'
          ],
          [
            'X', ' ', ' ',
            'X', ' ', ' ',
            'X', ' ', ' '
          ],
          [
            ' ', 'X', ' ',
            ' ', 'X', ' ',
            ' ', 'X', ' '
          ],
          [
            ' ', ' ', 'X',
            ' ', ' ', 'X',
            ' ', ' ', 'X'
          ],
          [
            'X', ' ', ' ',
            ' ', 'X', ' ',
            ' ', ' ', 'X'
          ],
          [
            ' ', ' ', 'X',
            ' ', 'X', ' ',
            'X', ' ', ' '
          ]
        ]
      end

      it 'returns true' do
        winner_boards.each do |winner_board|
          board.instance_variable_set(:@board, winner_board)
          expect(board.win?).to be true
        end
      end
    end

    context 'when there is no winner' do
      let(:not_winner_board) do
        [
          'X', 'O', 'X',
          'O', ' ', 'O',
          'X', 'O', 'X'
        ]
      end

      it 'returns false' do
        board.instance_variable_set(:@board, not_winner_board)
        expect(board.win?).to be false
      end
    end
  end
end
