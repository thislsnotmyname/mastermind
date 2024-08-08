require_relative 'lib/game'

# TODO:
#
# Three classes:
# Player
# Human extends Player
# Computer extends Player
#
# Two modules:
# Guess_Code mixin to Player
# Set_Code mixin to Player
#
# JM, 08/07/2024

# players = %w[Human Human].shuffle
game = Game.new('CPU', 'Human')
# p game.players
