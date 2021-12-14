# frozen_string_literal: true

template, rules = File.read("14.input").split("\n\n")
template = template.split("")
rules = rules.lines(chomp: true).map { |s| s.split(" -> ") }.to_h

current = template

10.times do
  result = current.each_cons(2).flat_map do |pair|
    [pair.first, rules[pair.join]]
  end
  result << current.last

  current = result
end

counts = current.group_by(&:itself).transform_values(&:size)
p(counts.values.max - counts.values.min)



pairs = template.each_cons(2).map(&:join).group_by(&:itself).transform_values(&:size)
counts = template.group_by(&:itself).transform_values(&:size)
counts.default = 0

40.times do
  result = Hash.new(0)
  pairs.each do |pair, count|
    middle = rules[pair]
    result["#{pair[0]}#{middle}"] += count
    result["#{middle}#{pair[1]}"] += count
    counts[middle] += count
  end
  pairs = result
end

p(counts.values.max - counts.values.min)
