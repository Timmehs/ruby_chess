require './resources'
  STRAIGHTS = [[-1,  0], [1,  0], [0, -1], [0,  1]]

# q = Queen.new([3,3], :black, b)
# bish = Bishop.new([0,0], :black, b)
# r = Rook.new([7,0], :black, b)
# p q.moves
# p bish.moves
# p r.moves

b = Board.new


b.move([1,5], [3,5])
b.move([6,4], [4,4])
b.move([1,6], [3,6])
b.move([7,3], [3,7])
b.display

p b.checkmate?(:black)
p b[[0,4]].valid_moves







