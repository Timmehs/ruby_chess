class Board
  attr_reader :grid
  
  class IllegalMoveError < StandardError; end
  
  def initialize(empty_board = false)
      @grid = Array.new(8) { Array.new(8) }
      set_board(@grid) unless empty_board
      @captured_pieces = []
  end
  
  def in_check?(color)
    king = king_pos(color)
    check = false
    @grid.flatten.compact.each do |piece|
      if piece && piece.color != color && piece.moves.include?(king)
        puts "CHECK!"
        check = true
      end
    end

    check
  end
  
  def king_pos(color)
    @grid.flatten.each do |piece|
      if piece && piece.is_a?(King) && piece.color == color
        return piece.pos
      end
    end
  end
  
  def display
    puts "CHESS".center(28)
    
    @grid.each_with_index do |row, i|
      row_str = "#{8 - i} "
      row.each_with_index do |piece, j|
        new_string = piece ? piece.to_s : "   \e[0m"
        row_str += background([i, j], new_string.center(3))
      end
      puts row_str
    end
    
    footer = ' '
    ('A'..'H').each { |letter| footer += "\e[36m#{letter.rjust(3)}\e[0m" }
    puts footer
    
    print_captured_pieces
  end
  
  def set_board(matrix)
    [:black, :white].each do |color|
      create_pawn_row(color, matrix)
      create_back_row(color, matrix)
    end
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
  

  
  def move(pos1, pos2)
    piece = self[pos1]
    target = self[pos2]
    
    begin
      raise IllegalMoveError.new("Can't move empty place") if !piece
      moves = piece.valid_moves
      raise IllegalMoveError.new("Illegal move")if !moves.include?(pos2)
      if piece && target
        capture_piece(piece, target)
      else
        self[pos1], self[pos2] = self[pos2], self[pos1]
      end
      piece.update_pos
      return true
    rescue IllegalMoveError => e
      puts "IllegalMoveError: #{e}"
      return false
    end
    
  end
  
  def capture_piece(piece, target)
    self[target.pos] = piece
    @captured_pieces << target
    self[piece.pos] = nil
  end
  
  def print_captured_pieces
    captured_str = "Captured: "
    @captured_pieces.each {|piece| captured_str += piece.to_s.rjust(3)}
    puts captured_str
  end
  def checkmate?(color)
    @grid.flatten.compact.each do |piece|
      next if piece.color != color
      return false unless piece.valid_moves.empty?
    end
    
    true
  end
  
  # moving for tests
  def move!(pos1, pos2)
    begin
      piece = self[pos1]
      raise IllegalMoveError.new("Can't move empty place") if !piece
      moves = piece.moves
      target = self[pos2]
      raise IllegalMoveError.new("Illegal move")if !moves.include?(pos2)
      
        
      self[pos1], self[pos2] = self[pos2], self[pos1]
      piece.update_pos
    
    rescue IllegalMoveError => e
      puts "IllegalMoveError: #{e}"
    end
  
  end
  
  
  def find(piece)
    @grid.each_with_index  do |row, i|
      row.each_with_index { |col, j| return [i, j] if col == piece }
    end
  end

  def dup
    dup_board = Board.new(true)
    @grid.flatten.compact.each do |piece|
      new_position = piece.pos
      new_color = piece.color
      new_piece = piece.class.new(new_position, new_color, dup_board )
      dup_board[piece.pos] = new_piece
    end

    dup_board
  end
  
  def [](pos)
    row, col = pos[0],pos[1]
    
    @grid[row][col]
  end
  
  def []=(pos, piece)
    row, col = pos[0],pos[1]
    @grid[row][col] = piece
  end
  
  def background(pos, string)
    background = ""
    if pos[0].even?
      background = pos[1].even? ? "\e[47m" : "\e[37m"
    else
      background = pos[1].odd? ? "\e[47m" : "\e[37m"
    end
    background + string
  end
  
end
