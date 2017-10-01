class Random_AI
	attr_reader :marker

	def initialize(marker)
		@marker = marker
	end

	def get_move(ttt_board)
		puts "It's #{marker}'s turn."

		move = ttt_board.sample
		p move
		if move == ''
			move
		else get_move(ttt_board)
		end
		move
	end
end