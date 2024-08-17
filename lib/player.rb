# JM, 08/13/2024
#
# This class is the parent of the Human and computer classes.
class Player
  attr_reader :conscious, :role, :player_name
  attr_accessor :guess_log

  def initialize(conscious, role, player_name = 'Bob')
    @role = role
    @conscious = conscious
    @player_name = player_name
    @guess_log = {}
  end

  def to_s
    "#{conscious} #{player_name}"
  end
end
