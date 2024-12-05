# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new }

  let(:symbol) { 'X' }
  let(:column) { 3 }

  describe '#add' do
    it 'adds the coin to the bottom of the column' do
      board.add(column, symbol)
      expected = board.positions[5][column]
      expect(expected).to eql symbol
    end

    it 'adds the second coin on top of last one' do
      board.add(column, symbol)
      board.add(column, symbol)
      expected = board.positions[4][column]
      expect(expected).to eql symbol
    end
  end

  describe '#column_full?' do
    before do
      board.add(column, symbol)
      board.add(column, symbol)
      board.add(column, symbol)
      board.add(column, symbol)
      board.add(column, symbol)
      board.add(column, symbol)
    end

    it 'returns true when column is full' do
      expect(board.column_full?(3)).to be true
    end

    it 'returns false if column is not full' do
      expect(board.column_full?(5)).to be false
    end
  end

  describe '#symbol_at' do
    it 'returns the symbol at given row and column' do
      board.add(column, symbol)
      expect(board.symbol_at(5, column)).to eql symbol
    end

    it 'returns nil if there is no symbol' do
      board.add(column, symbol)
      expect(board.symbol_at(0, column)).to be_nil
    end
  end
end
