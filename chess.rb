require './resources'


# q = Queen.new([3,3], :black, b)
# bish = Bishop.new([0,0], :black, b)
# r = Rook.new([7,0], :black, b)
# p q.moves
# p bish.moves
# p r.moves

b = Board.new

b.display

p b.in_check?(:white)

b.display
