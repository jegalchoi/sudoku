#require 'byebug'
#require 'pry'
require_relative 'board'
require_relative 'tile'
require_relative 'player'
require_relative 'solver'

input_prompt = '> '
puts "\nWelcome to Sudoku."
puts "\nEnter '1' for Human Player."
puts "Enter '2' for AI Player."
print input_prompt

player_type = gets.chomp.to_i
until (1..2).include?(player_type)
  puts "Please enter either '1' or '2'."
  print input_prompt
  player_type = gets.chomp.to_i
end

board = Board.new

if player_type == 1
  player = HumanPlayer.new
elsif player_type == 2
  player = ComputerPlayer.new
  player.solver.grid = board.grid
end

board.create_player(player)

until board.game_over?
  #debugger
  board.determine_possible_tiles
  if player_type == 2
    status = true
    player.solver.find_possible_value
    status = false unless player.solver.find_possible_value
    if status == false
      status = true
      player.solver.find_possible_value_in_nonet
      status = false unless player.solver.find_possible_value_in_nonet
    end
    if status == false
      status = true
      player.solver.find_possible_value_in_row
      status = false unless player.solver.find_possible_value_in_row
    end
    if status == false
      status = true
      player.solver.find_possible_value_in_col
    end
  end

  guess_pos = board.prompt_pos
  guess_value = board.prompt_value
  arr_nonet = board.arr_nonet
  nonet = board.determine_nonet(arr_nonet, guess_pos)
  guess_value = board.prompt_value until board.value_valid?(nonet, guess_pos, guess_value)
  board.set_value(guess_pos, guess_value)
end

