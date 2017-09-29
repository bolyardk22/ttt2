class Human
	attr_reader :marker

	def initialize(marker)
		@marker = marker
	end

	def get_move(ttt_board)
		puts "Make a move"
		move = gets.chomp.to_i - 1

		#for the sequential one try making it go through the array using a .each do
		#for the random one use a .sample

		if ttt_board[move] == ""
			move
		else
			puts "Spot already taken"
			get_move(ttt_board)
		end
	end
end
