require 'rainbow/refinement'

# This module handles the display of the board and the legend of colors.
#
# JM, 08/09/2024

using Rainbow

module Display # rubocop:disable Style/Documentation
  def display(guess = [], red = 0, white = 0)
    display = ' - - - - - | - - - - - '.split('')
    index = 1
    skip_to_corrects = 2 + ((5 - guess.length) * 2) # Leaves dashes for smaller guesses and skips the pipe.

    guess.each do |peg|
      display[index] = '●'.fg(Game::COLORS[peg])
      index += 2
    end
    index += skip_to_corrects

    display_corrects(display, index, red, white)
    print "Turn \##{turn_number} " << display_with_background(display)
  end

  def legend
    display = ' '
    Game::COLORS.each_value do |hex|
      display << '● '.fg(hex).bg('2F4F4F')
    end
    puts "\nLegend: \n" << display.bg('2F4F4F') << "\n 1 2 3 4 5 6 7 8 \n\n"
  end

  private

  def display_with_background(display)
    display.map { |item| item.bg('2F4F4F') }.join('')
  end

  def turn_number
    @turn > 9 ? @turn : "0#{@turn}"
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

  def win(winner)
    puts ''
    puts "Game over! #{winner} wins!"
  end
end
