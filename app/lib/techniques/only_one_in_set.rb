module Techniques
  module OnlyOneInSet
    extend ActiveSupport::Concern

    class_methods do
      def only_one_in_set(element_set)
        every_possibility = Hash.new([])
        element_set.reject { |e| e.square.solved }.each do |elem|
          elem.square.candidates.each { |c| every_possibility[c].push(elem.position) }
        end

        every_possibility.select { |_, v| v.length == 1 }.map do |pair|
          { type: :solve, position: pair.second.first, value: pair.first }
        end
      end
    end
  end
end
