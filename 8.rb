# frozen_string_literal: true

inputs = File.read("8.input").lines.map { |s| s.split(" | ").map { |x| x.split.map { |w| w.split("").sort } } }

p inputs.sum { |possibles, actuals|
  actuals.count { |a| [2, 3, 5, 7].include?(a.size) }
}

p inputs.sum { |possibles, actuals|
  possibles.sort_by!(&:size)

  # [1, 7, 4, [2, 3, 5], [0, 6, 9], 8]

  all = possibles[9]
  right = possibles[0]
  top = possibles[1] - right
  crosses = possibles[3, 3].reduce(:&)

  middle_and_topleft = possibles[2] - right

  middle = middle_and_topleft & crosses

  topleft = middle_and_topleft - middle
  bottomleft = all - crosses - topleft - right
  bottomright = possibles[6, 3].reduce(:&) & right
  topright = right - bottomright

  digits = [
    all - middle,
    right,
    crosses + topright + bottomleft,
    crosses + right,
    topleft + middle + right,
    crosses + topleft + bottomright,
    all - topright,
    top + right,
    all,
    all - bottomleft,
  ].map(&:sort)

  actuals.map { |n| digits.index(n) }.join.to_i
}
