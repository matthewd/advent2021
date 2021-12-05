# frozen_string_literal: true

position = depth = 0

inputs = File.read("2.input").lines.map(&:split)

inputs.each do |direction, count|
  count = count.to_i

  case direction
  when "forward"
    position += count
  when "up"
    depth -= count
  when "down"
    depth += count
  else
    raise
  end
end

p depth * position


aim = position = depth = 0

inputs.each do |direction, count|
  count = count.to_i

  case direction
  when "forward"
    position += count
    depth += aim * count
  when "up"
    aim -= count
  when "down"
    aim += count
  else
    raise
  end
end

p depth * position
