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
    board.add(column, @players[active_player])
  end

  def change_player
    @active_player = if @active_player == 'Player 1'
                       'Player 2'
                     else
                       'Player 1'
                     end
  end

  def win?
    player = @players[active_player]

    # horizontal check
    for j in 0..3 do
      for i in 0..5 do
        if @board.symbol_at(i, j) == player && @board.symbol_at(i, j + 1) == player &&
           @board.symbol_at(i, j + 2) == player && @board.symbol_at(i, j + 3) == player
          return true
        end
      end
    end

    # vertical check
    for j in 0..6 do
      for i in 0..2 do
        if @board.symbol_at(i, j) == player && @board.symbol_at(i + 1, j) == player &&
           @board.symbol_at(i + 2, j) == player && @board.symbol_at(i + 3, j) == player
          return true
        end
      end
    end

    # ascending diagonal check
    for j in 0..3 do
      for i in 3..5 do
        if @board.symbol_at(i, j) == player && @board.symbol_at(i - 1, j + 1) == player &&
           @board.symbol_at(i - 2, j + 2) == player && @board.symbol_at(i - 3, j + 3) == player
          return true
        end
      end
    end

    # descending diagonal check
    for j in 3..6 do
      for i in 3..5 do
        if @board.symbol_at(i, j) == player && @board.symbol_at(i - 1, j - 1) == player &&
           @board.symbol_at(i - 2, j - 2) == player && @board.symbol_at(i - 3, j - 3) == player
          return true
        end
      end
    end
    false
  end

  def valid?(number)
    if (number in 0..6) && !@board.column_full?(number)
      return true
    end

    false
  end
end
