class Solver
  PUZZLE_SIZE = 9

  attr_reader :puzzle

  def initialize(puzzle)
    @puzzle = puzzle
  end

  def solve
    loop do
      updates = Array.new(PUZZLE_SIZE * PUZZLE_SIZE) do |position|
        Techniques::OnlyOneCandidate.call(position, puzzle) \
          + Techniques::OnlyOneInRow.call(position, puzzle) \
          + Techniques::OnlyOneInColumn.call(position, puzzle) \
          + Techniques::OnlyOneInCube.call(position, puzzle)
      end.flatten.compact
      break if updates.length.zero?

      updates.each do |update|
        puzzle.get!(update[:position]).square.solve!(update[:value]) if update[:type] == :solve
      end
      puzzle.generate_candidates(true)
    end
    puzzle
  end
end
