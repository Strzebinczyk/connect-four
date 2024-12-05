require_relative '../lib/game'

describe Game do
  subject(:game) { described_class.new }

  describe '#add' do
    let(:symbol) { 'X' }
    let(:column) { 3 }

    it 'adds the coin to the bottom of the column' do
      game.add(column)
      expected = game.board.positions[5][column]
      expect(expected).to eql symbol
    end
    it 'adds the second coin on top of last one' do
      game.add(column)
      game.add(column)
      expected = game.board.positions[4][column]
      expect(expected).to eql symbol
    end
  end

  describe '#change_player' do
    it 'changes active player' do
      expect { game.change_player }.to change { game.active_player }.from('Player 1').to('Player 2')
    end
  end

  describe '#win?' do
    before do
      game.add(1)
      game.add(3)
      game.add(3)
      game.add(4)
      game.add(6)
      game.change_player
      game.add(2)
      game.add(3)
      game.add(5)
      game.add(4)
      game.add(4)
      game.add(4)
      game.change_player
      game.add(2)
      game.add(2)
      game.change_player
      # +    +    +    +    +    +    +    +
      # |    |    |    |    |    |    |    |
      # +----+----+----+----+----+----+----+
      # |    |    |    |    |    |    |    |
      # +----+----+----+----+----+----+----+
      # |    |    |    |    |  O |    |    |
      # +----+----+----+----+----+----+----+
      # |    |    |  X |  O |  O |    |    |
      # +----+----+----+----+----+----+----+
      # |    |    |  X |  X |  O |    |    |
      # +----+----+----+----+----+----+----+
      # |    |  X |  O |  X |  X |  O |  X |
      # +----+----+----+----+----+----+----+
      #   0    1    2    3    4    5    6
      #   Active Player: Player 2 (O)
    end

    it 'returns false when the game is not won by the current player' do
      expect(game.win?).to be false
    end

    it 'returns true when the game is won by current player (descending diagonal)' do
      game.add(2)
      expect(game.win?).to be true
    end

    it 'returns true when the game is won by current player (ascending diagonal)' do
      game.change_player
      game.add(0)
      game.add(1)
      game.add(3)
      expect(game.win?).to be true
    end

    it 'returns true when the game is won by current player (horizontal)' do
      game.add(5)
      game.add(5)
      game.add(6)
      game.add(6)
      expect(game.win?).to be true
    end

    it 'returns true when the game is won by current player (vertical)' do
      game.add(4)
      expect(game.win?).to be true
    end
  end

  describe '#valid?' do
    it 'returns true when provided valid column number' do
      column = 3
      expect(game.valid?(column)).to be true
    end

    it 'returns false when provided with not valid value' do
      column = 63
      expect(game.valid?(column)).to be false
    end
  end
end
