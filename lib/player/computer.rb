require_relative '../game/check'

# JM, 08/17/2024
#
# This class contains methods specific to the computer player.
# The codebreaking method uses Swaszek's method (1999-2000).
class Computer < Player
  include Check
  attr_reader :possible_codes, :game

  def initialize(role)
    super 'CPU', role, "CPU0#{(0..9).to_a.sample}"
    @turn = 0
    @possible_colors = Game::COLORS.keys
    make_code_list
  end

  def create_code
    code = []
    4.times do
      random_color = Game::COLORS.keys[Random.new.rand(5)]
      code.push(random_color)
    end
    code
  end

  def guess_code
    @turn += 1
    determine_possible_codes unless @turn == 1
    guess = @possible_codes[@turn == 1 ? 7 : 0]
    print ' Guess the secret code: ' << number_code(guess) << "\n"
    guess
  end

  private

  attr_writer :possible_codes

  def determine_possible_codes
    impossible_codes = []
    last_guess = @guess_log.values.last
    @possible_codes.each do |code|
      similarities = similarities_of(last_guess[:guess], code)
      impossible_codes << code unless similarities == last_guess[:similar]
    end
    @possible_codes -= impossible_codes
  end

  def make_code_list
    @possible_codes = []
    (0..5).to_a.repeated_permutation(4) do |perm|
      @possible_codes << perm
    end
    @possible_codes.sort!.map! do |code|
      code.map! { |peg| Game::COLORS.keys[peg] }
    end
  end

  def number_code(guess)
    guess
      .map { |color| Game::COLORS.keys.index(color) + 1 }
      .reduce('') { |acc, num| acc << num.to_s }
  end
end
