require_relative "grid_module"
require_relative "nonet_module"
require_relative 'valid_module'

class Solver
  attr_accessor :grid, :pos, :value
  include Grid, Nonet, Valid

  def initialize
    @grid = []
    @pos = []
    @value = " "
  end

  def find_possible_value
    @grid.each_with_index do |row, idx_row|
      row.each_with_index do |col, idx_col|
        pos = [idx_row, idx_col]
        next if self[pos].given || self[pos].possible_values.empty?
        if self[pos].possible_values.length == 1 && self[pos].value == " "
          self.pos = pos
          self.value = self[pos].possible_values[0]
          return true
        end
      end
    end
    false
  end

  def find_possible_value_in_nonet
    value = ""
    pos = []
    
    nonets = self.arr_nonet
    nonets.each_with_index do |nonet, idx|
      numbers = Hash.new(0)
      nonet.each { |tile| self[tile].possible_values.each { |value| numbers[value] += 1 } }
      value = numbers.key(1)
      next if value == nil
      
      pos_value = {}
      nonet.each { |tile| pos_value[tile] = value if self[tile].possible_values.include?(value) }
      unless pos_value == {} 
        self.pos = pos_value.keys.first
        self.value = pos_value.values.first
        return true
      end
    end
    false
  end

  def find_possible_value_in_row
    value = ""
    pos = []

    @grid.each_with_index do |row, idx_row|
      possible_values = Hash.new(0)
      row.each_with_index do |col, idx_col|
        pos = [idx_row, idx_col]
        self[pos].possible_values.each { |value| possible_values[value] += 1 }
      end
      value = possible_values.key(1)
      next if value == nil

      pos_value = {}
      row.each_with_index do |col, idx_col|
        pos = [idx_row, idx_col]
        pos_value[pos] = value if self[pos].possible_values.include?(value)
      end
      unless pos_value == {}
        self.pos = pos_value.keys.first
        self.value = pos_value.values.first
        return true
      end
    end
    false
  end
  
  def find_possible_value_in_col
    value = ""
    pos = []

    @grid.each_with_index do |row, idx_row|
      possible_values = Hash.new(0)
      row.each_with_index do |col, idx_col|
        pos = [idx_col, idx_row]
        self[pos].possible_values.each { |value| possible_values[value] += 1 }
      end
      value = possible_values.key(1)
      next if value == nil

      pos_value = {}
      row.each_with_index do |col, idx_col|
        pos = [idx_col, idx_row]
        pos_value[pos] = value if self[pos].possible_values.include?(value)
      end
      unless pos_value == {}
        self.pos = pos_value.keys.first
        self.value = pos_value.values.first
        return true
      end
    end
    false
  end
end