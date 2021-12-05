# frozen_string_literal: true

draws, *boards = File.read("4.input").split("\n\n")

draws = draws.split(",").map(&:to_i)
boards = boards.map { |b| b.lines.map { |row| row.split.map(&:to_i) } }


def win?(drawn, board)
  board.any? { |row| (row - drawn).empty? } ||
    board.transpose.any? { |column| (column - drawn).empty? }
end

drawn = []
draws.each do |latest|
  drawn << latest

  next unless board = boards.find { |board| win?(drawn, board) }

  remainder = (board.flatten - drawn).sum

  p remainder * latest
  break
end


last_winning_board = nil

drawn = []
draws.each do |latest|
  drawn << latest

  winners = boards.select { |board| win?(drawn, board) }

  winners.each do |board|
    remainder = (board.flatten - drawn).sum
    score = remainder * latest

    last_winning_board = score

    boards.delete(board)
  end
end

p last_winning_board
