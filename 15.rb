# frozen_string_literal: true

risk = File.read("15.input").lines(chomp: true).map { |s| s.split("").map(&:to_i) }

total = risk.map { |row| [nil] * row.size }

total.last[-1] = 0

changing = true
while changing
  changing = false

  total.each_with_index do |row, y|
    row.map!.with_index do |cell, x|
      next 0 if cell == 0

      neighbors = [[x - 1, y], [x + 1, y], [x, y - 1], [x, y + 1]].select { |a,b| a >= 0 && b >= 0 && a < row.size && b < total.size }
      neighbors.select! { |nx, ny| total[ny][nx] }

      new_cell = neighbors.map do |nx, ny|
        total[ny][nx] + risk[ny][nx]
      end.min

      changing ||= cell != new_cell

      new_cell
    end
  end
end

p total[0][0]


risk = 5.times.flat_map do |ri|
  risk.map do |row|
    5.times.flat_map do |ci|
      row.map do |cell|
        ((cell + ri + ci - 1) % 9) + 1
      end
    end
  end
end

total = risk.map { |row| [nil] * row.size }

total.last[-1] = 0

changing = true
while changing
  changing = false

  total.each_with_index do |row, y|
    row.map!.with_index do |cell, x|
      next 0 if cell == 0

      neighbors = [[x - 1, y], [x + 1, y], [x, y - 1], [x, y + 1]].select { |a,b| a >= 0 && b >= 0 && a < row.size && b < total.size }
      neighbors.select! { |nx, ny| total[ny][nx] }

      new_cell = neighbors.map do |nx, ny|
        total[ny][nx] + risk[ny][nx]
      end.min

      changing ||= cell != new_cell

      new_cell
    end
  end
end

p total[0][0]
