# require_relative 'player/human'
# require_relative 'player/computer'

# This class is to contain all of the player logic.
#
# JM, 08/09/2024
class Player
  attr_reader :conscious, :role, :player_name

  def initialize(conscious, role, player_name = 'Bob')
    @role = role
    @conscious = conscious
    @player_name = player_name
  end

  def to_s
    "#{conscious} #{player_name}"
  end
end
