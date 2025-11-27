module Techniques
  class OnlyOneInCube
    include OnlyOneInSet

    PUZZLE_SIZE = 9
    CUBE_SIZE = PUZZLE_SIZE / 3

    def self.call(position, puzzle)
      start_row = position / PUZZLE_SIZE / CUBE_SIZE * CUBE_SIZE
      start_column = position % PUZZLE_SIZE / CUBE_SIZE * CUBE_SIZE
      cube_set = (0..PUZZLE_SIZE-1).map do |i|
        row = start_row + (i / CUBE_SIZE)
        column = start_column + (i % CUBE_SIZE)
        puzzle.get!(row * PUZZLE_SIZE + column)
      end
      self.only_one_in_set(cube_set, :cube)
    end
  end
end
