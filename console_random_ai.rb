class Random_AI
	attr_reader :marker

	def initialize(marker)
		@marker = marker
	end

	def get_move(ttt_board)
		puts "It's #{marker}'s turn."

		num_arr = [0,1,2,3,4,5,6,7,8]
		shuff_arr = num_arr.shuffle
		move = shuff_arr.pop

		loop do
			if ttt_board[move] == ''
				move
				break
			else
				move = shuff_arr.pop
			end
		end
		move
	end
end