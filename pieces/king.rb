class King < SteppingPiece
  
  def potential_moves
    [[-1, 0], [-1, 1], [0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1]]
  end
  
  def to_s
   colorize("\u2654".center(3))
  end
end