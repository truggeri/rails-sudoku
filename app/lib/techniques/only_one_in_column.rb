module Techniques
  class OnlyOneInColumn
    include OnlyOneInSet

    PUZZLE_SIZE = 9

    def self.call(position, puzzle)
      column_offset = position % PUZZLE_SIZE
      column_set = (0..PUZZLE_SIZE-1).map { |i| puzzle.get!(column_offset + i * PUZZLE_SIZE) }
      self.only_one_in_set(column_set)
    end
  end
end
