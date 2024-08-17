# JM, 08/17/2024
#
# This module checks the secret code provided against a guess to determine its similarities.
module Check
  def similarities_of(guess, code)
    guess = guess.dup
    uncounted_pegs = code.dup

    red = check_reds(guess, code, uncounted_pegs)

    white = check_whites(guess, uncounted_pegs)

    { red: red, white: white }
  end

  private

  def check_reds(guess, code, uncounted_pegs)
    red = 0
    code.each_with_index do |peg, idx|
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
