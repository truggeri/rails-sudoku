class Puzzle
  attr_reader :elements

  PUZZLE_SIZE = 9
  CUBE_SIZE = PUZZLE_SIZE / 3
  EVERY_VALUE = Array.new(PUZZLE_SIZE) { |k| k + 1 }.freeze

  def initialize(input = [])
    cpy = input.map(&:clone)
    @elements = Array.new(PUZZLE_SIZE * PUZZLE_SIZE) do |i|
      Element.new(i, cpy.shift)
    end
    @values = {
      row: {},
      column: {},
      cube: {}
    }

    raise StandardError.new("Puzzle is not valid") unless valid?
    generate_candidates
  end

  def get!(index)
    raise StandardError.new("Given index must be positive") if index.negative?
    raise StandardError.new("Given index (#{index}) must less than #{PUZZLE_SIZE * PUZZLE_SIZE}") if index >= PUZZLE_SIZE * PUZZLE_SIZE

    elements[index]
  end

  def valid?
    (0..PUZZLE_SIZE - 1).each do |i|
      [ :row, :column, :cube ].each do |type|
        x = values(type, i).compact
        return false unless x.length == x.uniq.length
      end
    end
    true
  end

  def generate_candidates(force = false)
    @values = {
      row: {},
      column: {},
      cube: {}
    } if force

    elements.reject { |elem| elem.square.solved }.each_with_index do |elem, i|
      values_from_row = values(:row, elem.row)
      values_from_column = values(:column, elem.column)
      values_from_cube = values(:cube, elem.cube)
      candidates = EVERY_VALUE - values_from_row - values_from_column - values_from_cube
      elem.square.candidates = candidates
    end
  end

  def to_s
    output = ""
    elements.each_with_index do |elem, i|
      x = elem.square.solved ? elem.square.value : " "
      new_line = i.positive? && (i % PUZZLE_SIZE).zero? ? "\n" : ""
      output = "#{output}#{new_line} #{x}"
    end
    output
  end

  private

  def values(type, i)
    return @values[type][i] if @values[type][i]

    set = case type
    when :row
      self.get_row_elements(i)
    when :column
      get_column_elements(i)
    when :cube
      get_cube_elements(i)
    else
      []
    end
    @values[type][i] = set.map { |e| e.square.value }
  end

  def get_row_elements(row)
    elements.slice(row * PUZZLE_SIZE, PUZZLE_SIZE)
  end

  def get_column_elements(column)
    Array.new(PUZZLE_SIZE) { |i| elements[i * PUZZLE_SIZE + column] }
  end

  def get_cube_elements(cube)
    starting_row = (cube / CUBE_SIZE) * CUBE_SIZE
    starting_column = (cube % CUBE_SIZE) * CUBE_SIZE
    Array.new(PUZZLE_SIZE) do |i|
      cube_row = i / CUBE_SIZE
      cube_column = i % CUBE_SIZE
      elements[(starting_row + cube_row) * PUZZLE_SIZE + ((starting_column + cube_column))]
    end
  end
end
