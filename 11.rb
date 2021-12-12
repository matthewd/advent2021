# frozen_string_literal: true

inputs = File.read("11.input").lines(chomp: true).map { |s| s.split("").map(&:to_i) }

flashes = 0
ticks = 0

loop do
  ticks += 1

  inputs.each do |row|
    row.map! { |n| n + 1 }
  end

  while (inputs.flatten.compact.max || 0) > 9
    inputs.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        if cell && cell > 9
         inputs[y][x] = nil
         flashes += 1
         (-1..1).each do |yo|
           next unless (0...inputs.size) === y + yo
           (-1..1).each do |xo|
             next if xo == 0 && yo == 0
             next unless (0...inputs[y + yo].size) === x + xo

             if inputs[y + yo][x + xo]
               inputs[y + yo][x + xo] += 1
             end
           end
         end
        end
      end
    end
  end

  if ticks == 100
    p flashes
  end

  if inputs.flatten.compact.empty?
    p ticks
    break
  end

  inputs.each do |row|
    row.map! { |n| n || 0 }
  end
end
