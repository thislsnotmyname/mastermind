# This module contains methods for the human player
#
# JM, 08/07/2024
class Human < Player
  def initialize(role)
    super 'Human', role
  end

  def guess_code
    print ' Guess the secret code: '
    input = gets.chomp
    guess_length = input.length
    return guess_code unless guess_length <= 5

    input.gsub(' ', '').split('').map(&:to_i)[(0..4)].map do |number|
      return guess_code unless (1..8).include?(number)

      Game::COLORS.keys[number - 1]
    end
  end
end
