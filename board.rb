require 'byebug'
require 'pry'
require_relative 'tile'
require_relative 'player'
require_relative 'solver'
require_relative 'grid_module'
require_relative 'nonet_module'
require_relative 'valid_module'

puts 'START'

class Board
  attr_accessor :player, :grid
  include Grid, Nonet, Valid

  PUZZLE = IO.readlines('puzzle.txt').map { |n| n.chomp }.join("").split("")

  def initialize
    @player = ""
    @grid = Array.new(9) { Array.new(9) { Tile.tile_maker(Board::PUZZLE.shift) } }
  end

  def solved?
    if @grid.each { |row| row.each { |tile| return false if tile.value == " " } }; true
      self.clean_board
      self.render_board
      puts "\nCongratulations, you completed the board!"
      true
    else
      false
    end
  end

  def game_over?
    if self.solved?
      true
    else
      false
    end
  end

  def prompt_pos
    self.clean_board(1)
    self.render_board
    input_pos = @player.prompt_pos
    return input_pos if valid_pos?(input_pos) && !given_pos?(input_pos)
    self.prompt_pos
  end

  def prompt_value
    input_value = @player.prompt_value
  end

  def guess_pos
    pos_guess = self.prompt_pos
  end

  def guess_value
    value_guess = self.prompt_value
  end

  def set_value(pos, value)
    self[pos].value = value
    self[pos].possible_values = []
  end

  def determine_possible_tiles    
    @grid.each_with_index do |row, idx_row|
      row.each_with_index do |col, idx_col|
        pos = [idx_row, idx_col]
        value = self[pos].value
        next if self[pos].given || value != " "
        nonets = self.arr_nonet
        nonet = self.determine_nonet(nonets, pos)
        
        ("1".."9").each do |num|
          if value_valid?(nonet, pos, num)
            self[pos].set_possible_value(num) unless self[pos].possible_values.include?(num)
          else
            self[pos].possible_values.delete(num)
            self[pos].set_impossible_value(num) unless self[pos].impossible_values.include?(num)
          end
        end
      end
    end
  end

  def render_board
    50.times { print "-" }; puts "" 
    
    @grid.each do |row|   
      row.each do |tile|
        print "#{tile.value}" + " "
      end
      puts ""
    end

    50.times { print "-" }; puts ""
  end

  def clean_board(n=0.5)
    sleep(n)
    system("clear")
  end

  def create_player(player)
    @player = player
  end
end

#binding.pry

puts 'END'