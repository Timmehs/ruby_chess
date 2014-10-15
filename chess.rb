require './resources'
class Chess
  
  def initialize(save_game = false)
    @board = Board.new
    @player = HumanPlayer.new(@board)
  end
  
  def play
    puts "White goes first"
    white_turn = true
    until @board.checkmate?(:white) || @board.checkmate?(:black)
      begin
        @board.display
        turn = white_turn ? :white : :black
        puts "#{turn.to_s.capitalize} team's turn"
        piece, target = @player.play_turn
        raise StandardError if @board[piece].color != turn
        @board.move(piece, target)
      rescue StandardError
        puts "CANNOT MOVE OPPONENT'S PIECE!"
        retry
      end
      white_turn = !white_turn
    end
    winner = @board.checkmate?(:white) ? "black" : "white"
    puts "CHECKMATE!!! #{winner} won!"
    
  end
end

Chess.new.play