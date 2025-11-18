class Square
  attr_reader :solved, :value
  attr_accessor :candidates

  def initialize(number = nil)
    @solved = !number.nil?
    @value = number
  end

  def solve!(value)
    if solved
      raise StandardError.new("Cannot solve square because it is already solved")
    elsif candidates&.include?(value)
      raise StandardError.new("Cannot solve square with value #{value} because it is not a candidate for this square, #{candidates}")
    end

    @value = value
    @candidates = nil
    @solved = true
  end
end
