

class Bishop < SlidingPiece
    
  # def initialize(pos, color, board)
  #   super
  #   @diag = true
  # end
  
  def directions
    DIAGS
  end
  
  def to_s
    colorize("\u2657".center(3))
  end
end