# frozen_string_literal: true

inputs = File.read("1.input").lines.map(&:to_i)

p inputs.each_cons(2).count { |a, b| b > a }

windows = inputs.each_cons(3).map(&:sum)

p windows.each_cons(2).count { |a, b| b > a }
