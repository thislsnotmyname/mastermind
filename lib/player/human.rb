# JM, 08/17/2024
#
# This class contains methods specific to the human player.
class Human < Player
  def initialize(role)
    super 'Human', role
  end

  def create_code
    print 'Create a secret code of up to 4 colors: '
    code = gets.chomp
    return create_code unless code.length == 4

    delete_code_from_terminal

    code.gsub(' ', '').split('').map(&:to_i)[(0..3)].map do |number|
      return create_code unless (1..6).include?(number)

      Game::COLORS.keys[number - 1]
    end
  end

  def guess_code
    print ' Guess the secret code: '
    guess = gets.chomp
    return guess_code unless guess.length <= 4

    guess.gsub(' ', '').split('').map(&:to_i)[(0..3)].map do |number|
      return guess_code unless (1..6).include?(number)

      Game::COLORS.keys[number - 1]
    end
  end

  private

  def delete_code_from_terminal
    print "\e[A\e[K"
  end
end
