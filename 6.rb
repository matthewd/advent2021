# frozen_string_literal: true

inputs = File.read("6.input").split(",").map(&:to_i)

ages = inputs.dup
80.times do
  new_generation = ages.map { |a| a - 1 }
  spawn = new_generation.count(-1)
  ages = (new_generation - [-1]) + [6, 8] * spawn
end

p ages.size


ages = inputs.group_by(&:itself).transform_values(&:size)
256.times do
  new_generation = ages.transform_keys { |a| a - 1 }
  if spawn = new_generation.delete(-1)
    new_generation[6] ||= 0
    new_generation[6] += spawn
    new_generation[8] = spawn
  end
  ages = new_generation
end

p ages.values.sum
