# frozen_string_literal: true

require_relative '../../lib/player'

RSpec.describe Player do
  let(:name) { 'John Doe' }
  let(:token) { 'X' }

  subject(:player) { described_class.new(name:, token:) }

  describe '#identifier' do
    it 'returns the name and token of the player' do
      expect(subject.identifier).to eq('John Doe (X)')
    end
  end
end
