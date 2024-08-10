require_relative 'player'
require_relative 'player/human'
require_relative 'player/computer'
require_relative 'game/display'

# This class controls the game loop and game logic.
#
# JM, 08/09/2024
class Game
  include Display
  attr_reader :players

  COLORS = {
    red: '#FF0000',
    orange: '#FF8C00',
    green: '#00FF00',
    yellow: '#FFFF00',
    blue: '#0000FF',
    magenta: '#FF00FF',
    white: '#FFFFFF',
    black: '#000000'
  }

  def initialize(creator, guesser)
    @players = {
      creator: creator == 'Human' ? Human.new('Create') : Computer.new('Create'),
      guesser: guesser == 'Human' ? Human.new('Guess') : Computer.new('Guess')
    }
    @code = @players[:creator].send(:create_code)
    @turn = 0
    puts "#{@players[:creator].player_name} has chosen a code, begin!"
    legend
    game_loop
  end

  def game_loop
    display
    while @turn < 12
      @turn += 1
      guess = @players[:guesser].send(:guess_code)
      similar = similarities_of guess
      display(guess, similar[:red], similar[:white])
      return win(@players[:guesser]) if @code == guess
    end
    win(@players[:creator])
  end

  private

  attr_reader :code, :turn

  def similarities_of(guess)
    guess = guess.dup
    uncounted_pegs = @code.dup

    red = check_reds(guess, uncounted_pegs)

    white = check_whites(guess, uncounted_pegs)

    { red: red, white: white }
  end

  def check_reds(guess, uncounted_pegs)
    red = 0
    @code.each_with_index do |peg, idx|
      next unless peg == guess[idx]

      red += 1
      uncounted_pegs[idx] = guess[idx] = 'counted'
    end
    red
  end

  def check_whites(guess, uncounted_pegs)
    white = 0
    guess.each do |peg|
      next if peg == 'counted'

      next unless uncounted_pegs.include? peg

      white += 1
      uncounted_pegs[uncounted_pegs.index(peg)] = 'counted'
    end
    white
  end
end
