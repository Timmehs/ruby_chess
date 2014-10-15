require './sliding_piece'

class Bishop < SlidingPiece
    
  # def initialize(pos, color, board)
  #   super
  #   @diag = true
  # end
  
  def directions
    DIAGS
  end
  
  def to_s
    'B'
  end
end