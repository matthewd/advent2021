# frozen_string_literal: true

pos_str, fold_str = File.read("13.input").split("\n\n")

positions = pos_str.lines.map { |s| s.split(",").map(&:to_i) }
folds = fold_str.lines.map { |s| s =~ /fold along (.)=(.*)/; [$1, $2.to_i] }

height = positions.map(&:last).max + 1
width = positions.map(&:first).max + 1

grid = Array.new(height) { [false] * width }

positions.each do |x, y|
  grid[y][x] = true
end

folds.each_with_index do |(fold_dimension, fold_location), fold_idx|
  grid = grid.transpose if fold_dimension == "y"
  grid.map! do |row|
    row << false if row.size.even?

    row.first(fold_location).enum_for(:zip, row.reverse_each).map do |v1, v2|
      v1 || v2
    end
  end
  grid = grid.transpose if fold_dimension == "y"

  p grid.flatten.count(&:itself) if fold_idx == 0
end

puts grid.map { |r| r.map { |v| v ? "#" : "." }.join }
