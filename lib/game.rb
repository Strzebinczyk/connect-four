# frozen_string_literal: true

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
    (0..3).each do |j|
      (0..5).each do |i|
        if @board.symbol_at(i, j) == player && @board.symbol_at(i, j + 1) == player &&
           @board.symbol_at(i, j + 2) == player && @board.symbol_at(i, j + 3) == player
          return true
        end
      end
    end

    # vertical check
    (0..6).each do |j|
      (0..2).each do |i|
        if @board.symbol_at(i, j) == player && @board.symbol_at(i + 1, j) == player &&
           @board.symbol_at(i + 2, j) == player && @board.symbol_at(i + 3, j) == player
          return true
        end
      end
    end

    # ascending diagonal check
    (0..3).each do |j|
      (3..5).each do |i|
        if @board.symbol_at(i, j) == player && @board.symbol_at(i - 1, j + 1) == player &&
           @board.symbol_at(i - 2, j + 2) == player && @board.symbol_at(i - 3, j + 3) == player
          return true
        end
      end
    end

    # descending diagonal check
    (3..6).each do |j|
      (3..5).each do |i|
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
