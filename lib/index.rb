require_relative 'game'

game = Game.new

loop do
  game.board.display_board
  puts game.active_player
  column = game.get_input
  game.add(column)
  if game.win?
    puts "Congratulations #{game.active_player}, you won!"
    break
  end
  game.change_player
end
