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
    puts "#{@players[:creator].player_name} has chosen a code, begin!"
    print @code.to_s << "\n"
    legend
    display
    game_loop
  end

  def game_loop
    turns = 0
    while turns < 12
      guess = @players[:guesser].send(:guess_code)
      similar = similarities_of guess
      display(guess, similar[:red], similar[:white])
      return win(@players[:guesser]) if @code == guess

      turns += 1
    end
    win(@players[:creator])
  end

  def display(guess = nil, red = 0, white = 0)
    return print ' - - - - - | - - - - - '.bg('2F4F4F') if guess.nil?

    display = ' '
    guess.each do |peg|
      display << '● '.fg(COLORS[peg])
    end
    return print (display << '| - - - - - ').bg('2F4F4F') if red.zero? && white.zero?

    display << '| '
    red.times { display << '◉ '.fg('FF0000') }
    (5 - red).times { display << '- ' } if white.zero?
    white.times { display << '◉ '.fg('FFFFFF') }
    (5 - red - white).times { display << '- ' } unless (5 - red - white).zero?
    print display.bg('2F4F4F')
    # print "\n" << @code.to_s << "\n"
  end

  def legend
    display = ' '
    COLORS.each_value do |hex|
      display << '● '.fg(hex).bg('2F4F4F')
    end
    puts display.bg('2F4F4F') << "\n 1 2 3 4 5 6 7 8 "
    # display = ''
    # number = 0
    # COLORS.each do |color_name, hex|
    #   number += 1
    #   set = (' ' << number << ' ').fg(:white).bg(hex)
    #   set.fg(:black) if color_name == :white
    #   display << set
    # end
    # puts display
  end

  private

  attr_reader :code

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
    puts winner
  end
end
