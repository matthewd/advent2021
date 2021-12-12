# frozen_string_literal: true

input = File.read("12.input").lines(chomp: true).map { |s| s.split("-") }
doors = Hash.new { |h, k| h[k] = [] }
input.each do |a, b|
  doors[a] << b
  doors[b] << a
end

paths = []

location_stack = ["start"]
door_stack = []
loop do
  if location_stack.last == "end"
    paths << location_stack.dup
    available = []
  else
    excluded = location_stack.select { |s| s == s.downcase }

    available = doors[location_stack.last] - excluded
  end

  door_stack << available

  while location_stack.first && door_stack.last.empty?
    location_stack.pop
    door_stack.pop
  end

  break if location_stack.empty?

  location_stack << door_stack.last.shift
end

p paths.size


paths = []

location_stack = ["start"]
door_stack = []
loop do
  if location_stack.last == "end"
    paths << location_stack.dup
    available = []
  else
    excluded = location_stack.select { |s| s == s.downcase }

    excluded = ["start"] unless excluded.size > excluded.uniq.size

    available = doors[location_stack.last] - excluded
  end

  door_stack << available

  while location_stack.first && door_stack.last.empty?
    location_stack.pop
    door_stack.pop
  end

  break if location_stack.empty?

  location_stack << door_stack.last.shift
end

p paths.size
