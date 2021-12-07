# frozen_string_literal: true

inputs = File.read("7.input").split(",").map(&:to_i)

p (inputs.min..inputs.max).map { |pos|
  inputs.sum { |i| (pos - i).abs }
}.min


def cost(distance)
  distance * (distance + 1) / 2
end

p (inputs.min..inputs.max).map { |pos|
  inputs.sum { |i| cost((pos - i).abs) }
}.min
