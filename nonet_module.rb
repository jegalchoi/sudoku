module Nonet
  def determine_nonet(arr_nonet, input_pos)
    arr_nonet.each { |nonet| return nonet.map { |pos| self[pos].value } if nonet.include?(input_pos) }
  end

  def arr_nonet
    b_0 = []
    b_1 = []
    b_2 = []
    b_3 = []
    b_4 = []
    b_5 = []
    b_6 = []
    b_7 = []
    b_8 = []

    @grid.each_with_index do |row, idx_row|
      row.each_with_index do |col, idx_col|
          if idx_row <= 2 && idx_col <= 2
            b_0 << [idx_row, idx_col]
          elsif idx_col <= 5 && idx_col >= 3 && idx_row <= 2
            b_1 << [idx_row, idx_col]
          elsif idx_col >= 6 && idx_row <= 2
            b_2 << [idx_row, idx_col]
          elsif idx_row >= 3 && idx_row <= 5 && idx_col <= 2
            b_3 << [idx_row, idx_col]
          elsif idx_row <= 5 && idx_row >= 3 && idx_col >= 3 && idx_col <= 5
            b_4 << [idx_row, idx_col]
          elsif idx_row >= 3 && idx_row <= 5 && idx_col >= 6
            b_5 << [idx_row, idx_col]
          elsif idx_row >= 6 && idx_col <= 2
            b_6 << [idx_row, idx_col]
          elsif idx_row >= 6 && idx_col <= 5 && idx_col >= 3
            b_7 << [idx_row, idx_col]
          else
            b_8 << [idx_row, idx_col]
          end  
      end
    end
    arr_nonet = [b_0, b_1, b_2, b_3, b_4, b_5, b_6, b_7, b_8]
  end
end