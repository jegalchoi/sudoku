module Valid
  def valid_pos?(input)
    return true if input.first >= 0 && input.first < self.grid.length && input.last >= 0 && input.last < self.grid.length
    #puts "\nThat is an invalid position.  Please enter a valid position."
    false
  end

  def given_pos?(input)
    if self[input].given
      #puts "\nThat position is given.  Please enter a valid position."
      return true
    end
    false
  end

  def value_valid?(nonet, guess_pos, guess_value)
    if self.value_row_valid?(guess_pos, guess_value) && self.value_col_valid?(guess_pos, guess_value) && self.value_nonet_valid?(nonet, guess_value)
      return true
    end
    false
  end

  def value_row_valid?(input_pos, input_value)
    @grid.each_with_index do |row, idx_row|
      row.each_with_index do |col, idx_col|
          if idx_row == input_pos.first
            if self[[idx_row, idx_col]].value == input_value
              #puts "\nThat is an invalid value.  Please enter a valid position."
              return false
            end
          end
        end
    end
    true
  end

  def value_col_valid?(input_pos, input_value)
    @grid.each_with_index do |row, idx_row|
      row.each_with_index do |col, idx_col|
          if idx_col == input_pos.last
            if self[[idx_row, idx_col]].value == input_value
              #puts "\nThat is an invalid value.  Please enter a valid position."
              return false
            end
          end
        end
    end
    true
  end

  def value_nonet_valid?(nonet_values, input_value)
    if nonet_values.include?(input_value)
      #puts "\nThat is an invalid value.  Please enter a valid position."
      return false
    end
    true
  end
end