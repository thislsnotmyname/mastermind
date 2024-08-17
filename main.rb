require_relative 'lib/game'

# JM, 08/13/2024

player_configurations = {
  1 => %w[Human CPU],
  2 => %w[CPU Human],
  3 => %w[Human Human],
  4 => %w[CPU CPU]
}

puts 'Mastermind'

def game_mode
  puts "Please choose an option (Codesetter vs. Codebreaker):\n"\
  "1. Human vs. CPU\n"\
  "2. CPU vs. Human\n"\
  "3. Human vs. Human\n"\
  '4. CPU vs. CPU'
  mode = gets.chomp
  game_mode unless (1..4).to_a.include? mode[0].to_i
  mode.to_i
end
loop do
  mode = player_configurations[game_mode]
  Game.new(mode[0], mode[1])
  puts 'Play again? [y/n]'
  break unless gets.chomp.downcase == 'y'
end
