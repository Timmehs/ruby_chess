class Rook < SlidingPiece
    
  def directions
    STRAIGHTS
  end
  
  def to_s
   colorize("\u2656".center(3))
  end
end