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
			board_state = "game_over"
		end
	end

	def get_move
		active_player.get_move(board.ttt_board)
	end