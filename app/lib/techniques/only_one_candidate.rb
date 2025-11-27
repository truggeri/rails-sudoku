module Techniques
  class OnlyOneCandidate
    def self.call(position, puzzle)
      elem = puzzle.get!(position)
      return [] if elem.square.solved
      return [] if elem.square.candidates.length != 1

      [ { type: :solve, position: position, value: elem.square.candidates.first, source: :only_candidate } ]
    end
  end
end
