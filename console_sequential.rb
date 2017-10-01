class Sequential
	attr_reader :marker

	def initialize(marker)
		@marker = marker
	end

	def get_move(ttt_board)
		puts "It's #{marker}'s turn."

		move = 0
		9.times do
			if ttt_board[move] == ""
				move
				break
			else
				move += 1
			end
		end
		move
	end
end
