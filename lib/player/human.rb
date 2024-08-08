# This module contains methods for the human player
#
# JM, 08/07/2024
class Human < Player
  def initialize(role)
    @role = role
    super 'Human', role
  end

  def guess_code
    print 'Guess the secret code: '
    # guess = gets.chomp
  end
end
