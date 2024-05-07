# frozen_string_literal: true

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
