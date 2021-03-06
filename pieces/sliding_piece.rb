class SlidingPiece < Piece
  DIAGS =     [[-1, -1], [-1, 1], [1,  1], [1, -1]]
  STRAIGHTS = [[-1,  0], [1,  0], [0, -1], [0,  1]]

  def moves
    possible_moves = []
    directions.each do |direction|
      possible_moves += check_direction(@pos, direction)
    end
    possible_moves
  end
 
  def directions
    STRAIGHTS + DIAGS
  end
  
  # 7,0
  def check_direction(pos, dir)
    coords = []
    new_position = pos.dup
    row = new_position[0] + dir[0]
    col = new_position[1] + dir[1]
    new_position = [row, col]
    while valid_move?(new_position)
      #add if enemy and break out of loop
      coords << new_position
      if is_enemy?(new_position)
        new_position = [-1, -1]
      else
        row = new_position[0] + dir[0]
        col = new_position[1] + dir[1]
        new_position = [row, col]
      end
    end 
  
    coords
  end
end

