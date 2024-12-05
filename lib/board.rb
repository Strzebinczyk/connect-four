class Board
  attr_accessor :positions

  def initialize
    @positions = Array.new(6) { Array.new(7, nil) }
  end

  def display_board
    puts '+    +    +    +    +    +    +    +'
    @positions.each_index do |row|
      @positions[row].each_index do |column|
        if @positions[row][column].nil?
          print '|    '
        else
          print "| #{@positions[row][column]}  "
        end
      end
      puts '|'
      puts '+----+----+----+----+----+----+----+'
    end
    (0..6).each { |number| print "  #{number}  " }
    puts ''
  end
end
