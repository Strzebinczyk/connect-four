require_relative 'game'

def render(board)
  puts '+    +    +    +    +    +    +    +'
  board.positions.each_index do |row|
    board.positions[row].each_index do |column|
      if board.positions[row][column].nil?
        print '|    '
      else
        print "| #{board.positions[row][column]}  "
      end
    end
    puts '|'
    puts '+----+----+----+----+----+----+----+'
  end
  (0..6).each { |number| print "  #{number}  " }
  puts ''
end

def input(game)
  puts 'Please enter the column of your choice'
  column = gets.chomp.to_i
  until game.valid?(column)
    puts 'Please enter a valid column number'
    column = gets.chomp.to_i
  end
  column
end

game = Game.new

loop do
  render(game.board)
  puts game.active_player
  column = input(game)
  game.add(column)
  if game.win?
    puts "Congratulations #{game.active_player}, you won!"
    break
  end
  game.change_player
end
