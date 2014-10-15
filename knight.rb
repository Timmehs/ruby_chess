class Knight < SteppingPiece
  
  def potential_moves
    [[-2, -1], [-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [1, -2],[-1, -2] ]
  end
  
  def to_s
    'k'
  end
end