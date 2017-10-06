require_relative 'board.rb'

class Human
	attr_reader :marker

	def initialize(marker)
		@marker = marker
	end

	def get_move(ttt_board)
		puts "It's #{marker}'s turn."
		puts "Make a move"
		move = gets.chomp.to_i - 1

		if ttt_board[move] == ""
			move
		else
			puts "Spot already taken"
			get_move(ttt_board)
		end
		move
	end
end
