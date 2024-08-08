# This module contains methods for the computer player.
#
# JM, 08/07/2024
class Computer < Player
  def initialize(role)
    super 'CPU', role, "CPU0#{(0..9).to_a.sample}"
  end

  def create_code
    code = []
    5.times do
      random_color = Game::COLORS.keys[Random.new.rand(8)]
      code.push(random_color)
    end
    code
  end
end
