class Random_AI
	attr_reader :marker

	def initialize(marker)
		@marker = marker
	end

	def get_move(ttt_board)
		puts "It's #{marker}'s turn."

		num_arr = [0,1,2,3,4,5,6,7,8]

		move = num_arr.sample
		loop do
			if ttt_board[move] == ''
				move
				break
			else
			end
		end
		
		p "#{move}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		move
	end
end