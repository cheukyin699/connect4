require './lib/board.rb'

board = Board.new
turn = 1
columns = 0...7

puts "Connect 4!"

loop do
  puts columns.to_a.join
  puts board.to_s
  puts "Player #{turn}'s turn! Input a column to place piece in:"
  inp = gets.chomp.to_i

  if (0...7).include? inp
    begin
      y = board.put(inp, turn)
      break if board.check(inp, y) == turn
      turn = turn == 1 ? 2 : 1
    rescue RuntimeError
      puts "Column is full"
    end
  else
    puts "Column must be within [0,6]!"
  end
end

puts "Player #{turn} wins!"
