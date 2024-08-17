require_relative 'player'
require_relative 'player/human'
require_relative 'player/computer'
require_relative 'game/display'
require_relative 'game/check'

# JM, 08/17/2024
#
# This class controls the game loop and game logic.
class Game
  include Display
  include Check
  attr_reader :players, :turn, :winner

  COLORS = {
    red: '#FF0000',
    orange: '#FF8C00',
    green: '#00FF00',
    yellow: '#FFFF00',
    blue: '#0000FF',
    white: '#FFFFFF'
  }.freeze

  def initialize(creator, guesser)
    @players = {
      creator: creator == 'Human' ? Human.new('Create') : Computer.new('Create'),
      guesser: guesser == 'Human' ? Human.new('Guess') : Computer.new('Guess')
    }
    legend
    puts "#{@players[:creator].player_name}, please create a secret code:"
    @code = @players[:creator].send(:create_code)
    @turn = 0
    puts "#{@players[:creator].player_name} has chosen a code; #{@players[:guesser].player_name}, start guessing!"
    game_loop
  end

  def game_loop
    while @turn < 12
      @turn += 1
      display
      guess = @players[:guesser].send(:guess_code)
      similar = similarities_of(guess, @code)
      @players[:guesser].guess_log[@turn] = { guess: guess, similar: similar }
      display(guess, similar[:red], similar[:white])
      return win(@players[:guesser]) if @code == guess
    end
    win(@players[:creator])
  end

  private

  attr_reader :code
end
