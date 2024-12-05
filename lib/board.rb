class Board
  attr_reader :positions

  def initialize
    @positions = Array.new(6) { Array.new(7, nil) }
  end

  def add(column, symbol)
    row = 5
    while row >= 0
      if @positions[row][column].nil?
        @positions[row][column] = symbol
        return
      end
      row -= 1
    end
  end

  def column_full?(column)
    !positions[0][column].nil?
  end

  def symbol_at(row, column)
    @positions[row][column]
  end
end
