class HumanPlayer
  attr_reader :board
  class InputError < StandardError; end
  
  USER_INDEX = {} ; ('a'..'hlo').each_with_index { |a, i| USER_INDEX[a] = i }
  
  def initialize(board)
    @board = board
  end
  
  def play_turn
    board_copy = @board.dup
    piece = get_input("which piece")
    target = get_input("to which space")
    until board_copy.move(piece, target)
      piece = get_input("which piece")
      target = get_input("to which space")
    end
    [piece, target]
  end
  
  def get_input(target)
    begin
      puts "Move #{target}?"
      input = gets.chomp
      raise InputError unless /\A[a-h][12345678]\z/.match(input)

      translate_input(input)
    rescue InputError => e
      puts "#{e.message}: Please us the format a-h1-8 (i.e. f3, a2)"
      retry
    end
  end
  
  
  def translate_input(string)
    move = string.split("").reverse
    [8 - (move[0].to_i), USER_INDEX[move[1].downcase]]
  end
  
end