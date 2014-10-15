require './resources'
  STRAIGHTS = [[-1,  0], [1,  0], [0, -1], [0,  1]]

# q = Queen.new([3,3], :black, b)
# bish = Bishop.new([0,0], :black, b)
# r = Rook.new([7,0], :black, b)
# p q.moves
# p bish.moves
# p r.moves

b = Board.new
b.move([1,2], [3,2])
b.move([0,3], [3,0])
b.move([6,3], [5,3])

b.display

p b.in_check?(:white)

p b.find(b[[1,6]])





