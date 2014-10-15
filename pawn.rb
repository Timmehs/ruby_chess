class Pawn < Piece
 attr_accessor :first_move
 
  def initialize(pos, color, board)
    super
    @first_move = true
  end
  
  def to_s
    'p'
  end
  
  
  def moves
    potential_moves = []
    possible_moves.each do |move|
      potential_moves << move if valid_move?(move)
    end
    
    potential_moves + possible_captures
  end
  
  def possible_moves
    moves = [[1,0]]
    
    if @first_move
      moves << [2,0]
      @first_move = false
    end
    
    if @color == :white
      moves.map! do |move|
        move[0] *= -1
        move
      end
    end
    moves.map! do |move| 
      #move.each_with_index.map { |el, i| el += @pos[i] }
      [move[0] + @pos[0], move[1] + @pos[1]]
    end
    moves
  end
  
  def possible_captures
    captures = [[-1, -1], [-1, 1]]
    captures.map! {|coord| coord[0] *= -1; coord } if @color == :black
    captures.map! {|coord| [coord[0] + @pos[0], coord[1] + @pos[1]] }
    # [5, 4], [5, 6]
    captures.keep_if { |coord| is_enemy?(coord) }
  end
  
  def is_enemy?(pos)
    !@board[pos].nil? && @board[pos].color != @color
  end
      
  
end