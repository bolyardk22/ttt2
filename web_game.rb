require_relative 'board.rb'
require_relative 'console_human.rb'
require_relative 'console_sequential.rb'
require_relative 'console_random_ai.rb'
require_relative 'console_impossible.rb'

class Web_game
	attr_accessor :player_1, :player_2, :board, :active_player, :move, :input1, :input2

	def initialize
		@player_1 = get_player_1
		@player_2 = get_player_2
		@board = Board.new
		@active_player = player_2
	end

	def display_board
		#actually checks for game over; name is a remenant
		if check_winner || board.full_board?
			board_state = "full"
		else
			board_state = "not_full"
		end
	end

	def get_move
		active_player.get_move(board.ttt_board)
	end

	def update_board
		marker = active_player.marker
		move = get_move

		if board.valid_position?(move)
			board.update_position(move,marker)

		else
			update_board
		end
	end

	def change_player
		if active_player == player_1
			@active_player = player_2
		else
			@active_player = player_1
		end
	end

	def check_winner
		if board.winner?(active_player.marker)
			true
		else
			false
		end
	end

	def get_player_1(radio_button1)
		@input1 = radio_button1

		if input1 == 1
			@player_1 = Human.new('X')
		elsif input1 == 2
			@player_1 = Sequential.new('X')
		elsif input1 == 3
			@player_1 = Random_AI.new('X')
		elsif input1 == 4
			@player_1 = Impossible.new('X')
		end
	end

	def get_player_2(radio_button2)
		@input2 = radio_button2

		if input2 == 1
			@player_2 = Human.new('O')
		elsif input2 == 2
			@player_2 = Sequential.new('O')
		elsif input2 == 3
			@player_2 = Random_AI.new('O')
		elsif input2 == 4
			@player_2 = Impossible.new('O')
		end
	end
end