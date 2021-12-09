# frozen_string_literal: true

inputs = File.read("9.input").lines.map { |s| s.chomp.split("").map(&:to_i) }

def adjacencies(grid, x, y)
  [
    (grid[y][x - 1] if x > 0),
    grid[y][x + 1],
    (grid[y - 1][x] if y > 0),
    grid.dig(y + 1, x),
  ].compact
end

p(inputs.enum_for(:sum).with_index do |row, y|
  row.enum_for(:sum).with_index do |cell, x|
    if adjacencies(inputs, x, y).min > cell
      1 + cell
    else
      0
    end
  end
end)

basins = 0

inputs.each_with_index do |row, y|
  row.each_with_index do |cell, x|
    if adjacencies(inputs, x, y).min > cell
      inputs[y][x] = -(basins += 1)
    end
  end
end

changes = true
while changes
  changes = false

  inputs.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      next if cell < 0 # already part of a basin
      next if cell == 9 # never a basin

      lowest = adjacencies(inputs, x, y).min

      # adjacent to a basin; move in to it
      if lowest < 0
        changes = true
        inputs[y][x] = lowest
      end
    end
  end
end

sizes = inputs.flatten.group_by(&:itself).transform_values(&:size)

p (1..basins).map { |b| sizes[-b] }.sort.last(3).inject(:*)
