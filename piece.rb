class Piece
  attr_reader :pos, :color, :board
  attr_writer :pos
  
  class IllegalMoveError < StandardError; end
  class NotImplementedError < StandardError; end
  
  def initialize(pos, color, board)
    @pos   = pos
    @color = color
    @board = board
  end
  
  def moves
    raise NotImplementedError.new("Moves method not implemented")
  end
  
  
  def on_board?(pos)
    row, col = pos
    row.between?(0,7) && col.between?(0,7)
  end
  
  def valid_move?(pos)
    on_board?(pos) && (@board[pos].nil? || @board[pos].color != @color)
    # return false unless on_board?(pos)    #
    # if !@board[pos].empty?
    #   return false if @color == @board[pos].color
    # else
    #   return true
    # end
  end
  
end