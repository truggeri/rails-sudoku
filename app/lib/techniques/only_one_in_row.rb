module Techniques
  class OnlyOneInRow
    include OnlyOneInSet

    PUZZLE_SIZE = 9

    def self.call(position, puzzle)
      set_start = position / PUZZLE_SIZE
      row_set = (1..PUZZLE_SIZE).map { |i| puzzle.get!(set_start + i) }
      self.only_one_in_set(row_set)
    end
  end
end
