class HumanPlayer
  attr_reader :board
  class InputError < StandardError; end
  
  USER_INDEX = {} ; ('a'..'h').each_with_index { |a, i| USER_INDEX[a] = i }
  
  def initialize(board)
    @board = board
  end
  
  def play_turn
    [get_input("which piece"), get_input("to which space")]
  end
  
  def get_input(target)
    begin
      puts "Move #{target}?"
      input = gets.chomp
      raise InputError unless /\A[a-h][12345678]\z/.match(input)
      if @board[translate_input(input)].nil? && target == "which piece"
        raise StandardError
      end
      translate_input(input)
    rescue InputError => e
      puts "#{e.message}: Please us the format a-h1-8 (i.e. f3, a2)"
      retry
    rescue StandardError
      puts "Can't move an empty space!"
      retry
    end
  end
  
  
  def translate_input(string)
    move = string.split("").reverse
    [8 - (move[0].to_i), USER_INDEX[move[1].downcase]]
  end
  
end