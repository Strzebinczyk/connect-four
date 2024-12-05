require_relative 'board'
class Game
  attr_reader :players, :board
  attr_accessor :active_player

  def initialize
    @board = Board.new
    @players = { 'Player 1' => 'X', 'Player 2' => 'O' }
    @active_player = 'Player 1'
  end

  def add(column)
    row = 5
    while row >= 0
      if @board.positions[row][column].nil?
        @board.positions[row][column] = @players[@active_player]
        return
      end
      row -= 1
    end
  end

  def change_player
    @active_player = if @active_player == 'Player 1'
                       'Player 2'
                     else
                       'Player 1'
                     end
  end

  def column_full?(column)
    return false if @board.positions[0][column].nil?

    true
  end

  def win?
    player = @players[active_player]

    # horizontal check
    for j in 0..3 do
      for i in 0..5 do
        if @board.positions[i][j] == player && @board.positions[i][j + 1] == player &&
           @board.positions[i][j + 2] == player && @board.positions[i][j + 3] == player
          return true
        end
      end
    end

    # vertical check
    for j in 0..6 do
      for i in 0..2 do
        if @board.positions[i][j] == @players[@active_player] && @board.positions[i + 1][j] == @players[@active_player] && @board.positions[i + 2][j] == @players[@active_player] && @board.positions[i + 3][j] == @players[@active_player]
          return true
        end
      end
    end

    # ascending diagonal check
    for j in 0..3 do
      for i in 3..5 do
        if @board.positions[i][j] == @players[@active_player] && @board.positions[i - 1][j + 1] == @players[@active_player] && @board.positions[i - 2][j + 2] == @players[@active_player] && @board.positions[i - 3][j + 3] == @players[@active_player]
          return true
        end
      end
    end

    # descending diagonal check
    for j in 3..6 do
      for i in 3..5 do
        if @board.positions[i][j] == @players[@active_player] && @board.positions[i - 1][j - 1] == @players[@active_player] && @board.positions[i - 2][j - 2] == @players[@active_player] && @board.positions[i - 3][j - 3] == @players[@active_player]
          return true
        end
      end
    end
    false
  end

  def get_input
    puts 'Please enter the column of your choice'
    column = gets.chomp.to_i
    until valid?(column)
      puts 'Please enter a valid column number'
      column = gets.chomp.to_i
    end
    column
  end

  def valid?(number)
    if (number in 0..6) && !column_full?(number)
      return true
    end

    false
  end
end
