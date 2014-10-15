class Rook < SlidingPiece
    
  def directions
    STRAIGHTS
  end
  
  def to_s
    'R'
  end
end