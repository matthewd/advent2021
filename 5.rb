# frozen_string_literal: true

inputs = File.read("5.input").lines.map { |s| s.split(/[^\d]+/).map(&:to_i) }

x1s, y1s, x2s, y2s = inputs.transpose

max_x = (x1s + x2s).max
max_y = (y1s + y2s).max

grid = Array.new(max_y + 1) { [0] * (max_x + 1) }

inputs.each do |x1, y1, x2, y2|
  if x1 == x2
    y1, y2 = y2, y1 if y1 > y2
    y1.upto(y2) do |y|
      grid[y][x1] += 1
    end
  elsif y1 == y2
    x1, x2 = x2, x1 if x1 > x2
    x1.upto(x2) do |x|
      grid[y1][x] += 1
    end
  end
end

p grid.flatten.count { |cell| cell > 1 }



grid = Array.new(max_y + 1) { [0] * (max_x + 1) }

inputs.each do |x1, y1, x2, y2|
  xs = (x1..x2).step(x2 <=> x1)
  ys = (y1..y2).step(y2 <=> y1)

  while true
    x, y = xs.next, ys.next
    grid[y][x] += 1
  end
rescue StopIteration
end

p grid.flatten.count { |cell| cell > 1 }
