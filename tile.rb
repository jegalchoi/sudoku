class Tile
attr_accessor :value, :given, :possible_values, :impossible_values

  def initialize(value)
    @value = value
    @given = false
    @possible_values = []
    @impossible_values = []
  end

  def self.tile_maker(value)
    if value == "0"
      Tile.new(" ")
    else
      tile = Tile.new(value)
      tile.set_given
      tile.set_impossible_value(value)
      tile.set_initial_impossible_values
      tile
    end
  end

  def set_initial_impossible_values
    ("1".."9").each { |num| self.impossible_values << num unless self.impossible_values.include?(num) }
  end

  def set_possible_value(value)
    self.possible_values << value
  end

  def set_impossible_value(value)
    self.impossible_values << value
  end

  def set_given
    self.given = true
  end
end