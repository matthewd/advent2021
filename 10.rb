# frozen_string_literal: true

lines = File.read("10.input").lines(chomp: true)

CLOSE = { "(" => ")", "[" => "]", "{" => "}", "<" => ">" }

ERROR_SCORES = { ")" => 3, "]" => 57, "}" => 1197, ">" => 25137 }
COMPLETION_SCORES = { ")" => 1, "]" => 2, "}" => 3, ">" => 4 }

error_score = 0
completion_scores = []

lines.each do |line|
  stack = []
  unexpected = nil

  line.chars.each do |c|
    case c
    when *CLOSE.keys
      stack << CLOSE[c]
    when stack.last
      stack.pop
    else
      unexpected = c
      break
    end
  end

  if unexpected
    error_score += ERROR_SCORES[unexpected]
  else
    completion_scores << stack.reverse.inject(0) do |score, needed|
      score * 5 + COMPLETION_SCORES[needed]
    end
  end
end

p error_score
p completion_scores.sort[completion_scores.size / 2]
