class SteppingPiece < Piece
  
  def moves
    possible_moves = []
    potential_moves.each do |move|
      possible_moves << new_move(move) if valid_move?(new_move(move))
    end
    possible_moves
  end
  
  def new_move(move)
    new_position = [@pos[0] + move[0] , @pos[1] + move[1]]
  end
  
  def potential_moves
    raise NotImplementedError.new("Potential Moves not implemented for #{self.class}")
  end
end