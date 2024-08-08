require_relative 'player'
require_relative 'player/human'
require_relative 'player/computer'
require 'rainbow'

# This class controls the game loop and game logic.
# ◉
# JM, 08/07/2024
class Game
  attr_reader :players

  COLORS = {
    red: '#FF0000',
    green: '#00FF00',
    yellow: '#FFFF00',
    blue: '#0000FF',
    magenta: '#FF00FF',
    cyan: '#00FFFF',
    white: '#FFFFFF',
    gray: '#778899'
  }

  def initialize(creator, guesser)
    @players = {
      creator: creator == 'Human' ? Human.new('Create') : Computer.new('Create'),
      guesser: guesser == 'Human' ? Human.new('Guess') : Computer.new('Guess')
    }

    @code = @players[:creator].send(:create_code)
    display
    # game_loop
  end

  def game_loop
    # loop do
    # guess = @players[:guesser].send(:guess_code)
    # display
    # break if @code == guess
    # end
  end

  def display
    display = Rainbow(' ').bg '#000000'
    COLORS.each_value do |hex|
      display << Rainbow('● ').fg(hex).bg('#000000')
    end
    print display << "\n"
    print @code.to_s << "\n"
  end

  private

  attr_reader :code
end
