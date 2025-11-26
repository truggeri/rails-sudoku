# Element represents a square of the puzzle with its known position in the puzzle
class Element
  PUZZLE_SIZE = 9
  CUBE_SIZE = PUZZLE_SIZE / 3

  attr_reader :square, :row, :column, :cube, :position

  def initialize(index, value = nil)
    @square = Square.new(value)
    @position = index
    @row = index / PUZZLE_SIZE
    @column = index % PUZZLE_SIZE
    @cube = (row / CUBE_SIZE) * CUBE_SIZE + (column / CUBE_SIZE)
  end
end
