# frozen_string_literal: true

# Player represents a participant in the Tic Tac Toe game.
class Player
  attr_reader :name, :token

  def initialize(name:, token:)
    @name = name
    @token = token
  end

  def identifier
    "#{name} (#{token})"
  end
end
