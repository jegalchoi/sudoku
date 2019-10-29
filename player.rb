require 'byebug'
require 'pry'

class Player
  attr_accessor :pos, :value

  def initialize
    @pos = []
    @value = " "
  end

  def prompt_pos
    puts "\nPlease enter the position of the tile you would like to fill (e.g., '2,3')."
    self.input_pos
  end

  def prompt_value
    puts "\nPlease enter the value of the tile (e.g., '4')."
    self.input_value
  end
end

class HumanPlayer < Player
  def input_pos
    pos = gets.chomp 
    pos = gets.chomp until self.valid_input_pos?(pos)
    pos.split(",").map { |n| n.to_i }
  end

  def valid_input_pos?(input)
    if !input.include?(",") || /[a-z]/ =~ input
      puts "\nThat is an invalid entry.  Please try again."
      return false
    end
    true
  end

  def input_value
    val = gets.chomp
    val = gets.chomp until self.valid_input_value?(val)
    val
  end

  def valid_input_value?(input)
    if !(/[1-9]/ =~ input)
      puts "\nThat is an invalid entry.  Please try again."
      return false
    end
    true
  end
end

class ComputerPlayer < Player
  attr_accessor :solver

  def initialize
    @solver = Solver.new
  end

  def input_pos
    pos = solver.pos
  end

  def input_value
    val = solver.value
  end
end

#binding.pry

puts 'END'