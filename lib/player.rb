# require_relative 'player/human'
# require_relative 'player/computer'

# This class is to contain all of the player logic.
#
# JM, 08/07/2024
class Player
  # include Human if is_human == true
  # include Computer if is_human == false
  # include Human
  # include Computer

  attr_reader :conscious, :role, :player_name

  def initialize(conscious, role, player_name = 'Bob')
    @role = role
    @conscious = conscious
    @player_name = player_name
  end
end
