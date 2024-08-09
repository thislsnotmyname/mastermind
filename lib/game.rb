require_relative 'player'
require_relative 'player/human'
require_relative 'player/computer'
require 'rainbow/refinement'

using Rainbow

# This class controls the game loop and game logic.
# ◉
# JM, 08/07/2024
class Game
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

  def display(guess = nil, red = 0, white = 0)
    display = ' - - - - - | - - - - - '.split('')
    index = 1
    return print("Turn \##{@turn} " << display.map { |item| item.bg('2F4F4F') }.join('')) if guess.nil?

    guess.each do |peg|
      display[index] = '●'.fg(COLORS[peg])
      index += 2
    end
    index += (2 + ((5 - guess.length) * 2)) # Leaves dashes for smaller guesses and skips the pipe.

    display_corrects(display, index, red, white)
    print("Turn \##{@turn} " << display.map { |item| item.bg('2F4F4F') }.join(''))
  end

  def display_corrects(display, index, red, white)
    red.times do
      display[index] = 'Δ'.fg('FF0000')
      index += 2
    end
    white.times do
      display[index] = 'Δ'.fg('FFFFFF')
      index += 2
    end
  end

  def legend
    display = ' '
    COLORS.each_value do |hex|
      display << '● '.fg(hex).bg('2F4F4F')
    end
    puts display.bg('2F4F4F') << "\n 1 2 3 4 5 6 7 8 "
  end

  private

  attr_reader :code, :turn

  def similarities_of(guess)
    red = white = 0
    guess = guess.dup
    uncounted_pegs = @code.dup
    @code.each_with_index do |peg, idx|
      next unless peg == guess[idx]

      red += 1
      uncounted_pegs[idx] = guess[idx] = 'counted'
    end
    return { red: red, white: white } if red == 5

    guess.each do |peg|
      next if peg == 'counted'

      next unless uncounted_pegs.include? peg

      white += 1
      uncounted_pegs[uncounted_pegs.index(peg)] = 'counted'
    end
    { red: red, white: white }
  end

  def win(winner)
    puts ''
    puts winner
  end
end
