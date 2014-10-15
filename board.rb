class Board
  attr_reader :grid
  
  def initialize
    @grid = new_board
  end
  
  def in_check?(color)
    king = king_pos(color)
    check = false
    @grid.each do |row|
      row.each do |piece|
        if piece && piece.color == color
          check = true if piece.moves.include?(king)  
        end
      end
    end
    check
  end
  
  def king_pos(color)
    @grid.each do |row|
      row.each do |piece|
        if piece 
          if piece.is_a?(King) && piece.color == color
            puts "KING FOUND: #{piece.pos}"
          end
        end
      end
    end
  end
  
  def display
    puts "          CHESS"
    @grid.each_with_index do |row, i|
      row_str = "\e[36m#{i}\e[0m"
      row.each_with_index do |piece, j|
        if piece
          row_str += piece.to_s.rjust(3)
        else
          row_str += "_".rjust(3)
        end
      end
      puts row_str
    end
    footer = ' '
    (0..7).each do |index|
      footer += "\e[36m#{index.to_s.rjust(3)}\e[0m"
    end
    puts footer
  end
  
  def new_board
    matrix = Array.new(8, Array.new(8))
    [:black, :white].each do |color|
      create_pawn_row(color, matrix)
      create_back_row(color, matrix)
    end
    
    matrix
  end
  
  def create_pawn_row(color, matrix)
    row = color == :black ? 1 : 6
    pawns = []
    (0..7).each do |i|
      pawns << Pawn.new([row, i], color, self)
    end
    
    matrix[row] = pawns
  end
  
  def create_back_row(color, matrix)
    
    row = color == :black ? 0 : 7
    
    new_pieces = [
      Rook.new([row, 0], color, self),
      Knight.new([row, 1], color, self),
      Bishop.new([row, 2], color, self),
      Queen.new([row, 3], color, self),
      King.new([row, 4], color, self),
      Bishop.new([row, 5], color, self),
      Knight.new([row, 6], color, self),
      Rook.new([row, 7], color, self),
    ]
    
    matrix[row] = new_pieces
  end
  
  def [](pos)
    row, col = pos[0],pos[1]
    
    @grid[row][col]
  end
  
  def []=(pos, piece)
    row, col = pos[0],pos[1]

    @grid[row][col] = piece
  end
end
