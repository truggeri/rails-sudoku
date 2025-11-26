module Techniques
  class OnlyOneInCube
    PUZZLE_SIZE = 9
    CUBE_SIZE = PUZZLE_SIZE / 3

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
      start_row = position / PUZZLE_SIZE / CUBE_SIZE * CUBE_SIZE
      start_column = position % PUZZLE_SIZE / CUBE_SIZE * CUBE_SIZE
      (0..PUZZLE_SIZE-1).map do |i|
        row = start_row + (i / CUBE_SIZE)
        column = start_column + (i % CUBE_SIZE)
        puzzle.get!(row * PUZZLE_SIZE + column)
      end
    end
  end
end
