module Techniques
  class OnlyOneInColumn
    PUZZLE_SIZE = 9

    def self.call(position, puzzle)
      element_set = build_set(position, puzzle)
      every_possibility = Hash.new([])
      element_set.reject { |e| e.square.solved }.each do |elem|
        elem.square.candidates.each { |c| every_possibility[c].push(elem.position) }
      end

      every_possibility.select { |_, v| v.length == 1 }.map do |pair|
        { type: :solve, position: pair.second.first, value: pair.first }
      end
    end

    private

    def self.build_set(position, puzzle)
      column_offset = position % PUZZLE_SIZE
      (0..PUZZLE_SIZE-1).map { |i| puzzle.get!(column_offset + i * PUZZLE_SIZE) }
    end
  end
end
