# frozen_string_literal: true

inputs = File.read("3.input").lines

digits = inputs.map { |s| s.chomp.split("") }

gamma = digits.transpose.map do |samples|
  samples.sort[samples.size / 2]
end.join.to_i(2)

epsilon = gamma ^ (2 ** 12 - 1)

p gamma * epsilon


def list_filter(digits, want_most_common)
  list = digits.map { |row| [row, row.join.to_i(2)] }

  while list.size > 1
    common_digit = list.sort[list.size / 2].first.first

    list.select! do |row, _original|
      is_most_common = row.first == common_digit

      want_most_common == is_most_common
    end

    list = list.map { |row, original| [row.drop(1), original] }
  end

  list.first.last
end

oxygen = list_filter(digits, true)
co2 = list_filter(digits, false)

p oxygen * co2
