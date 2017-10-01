class Sequential
	attr_reader :marker

	def initialize(marker)
		@marker = marker
	end

	def get_move(ttt_board)
		puts "It's #{marker}'s turn."

		move = 0
		loop do
			if ttt_board[move] == ""
				break
				move
			else
				move += 1
			end
		end
	end
end
