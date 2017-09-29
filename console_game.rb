require_relative 'board.rb'
require_relative 'player_classes.rb'

class Console_game
	attr_accessor :player_1, :player_2, :board, :active_player, :move, :input1, :input2

	def initialize
		@player_1 = get_player_1
		@player_2 = get_player_2
		@board = Board.new
		@active_player = player_1
	end

	def intro
		puts "Welcome to tic-tac-toe!"
	end

	def display_board
		puts "#{board.ttt_board[0]} || #{board.ttt_board[1]} || #{board.ttt_board[2]}"
		puts "==========="
		puts "#{board.ttt_board[3]} || #{board.ttt_board[4]} || #{board.ttt_board[5]}"
		puts "==========="
		puts "#{board.ttt_board[6]} || #{board.ttt_board[7]} || #{board.ttt_board[8]}"

		if check_winner || board.full_board?
			puts "Game over."
		else
			puts "It's #{active_player.marker}'s turn."
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

		else puts "Invalid move; please choose again."
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

	def get_player_1
		puts """
		Please select player 1 by entering a number below.
		1 - Human
		2 - Sequential Computer
		3 - Random Computer
		"""

		@input1 = gets.chomp.to_i

		if input1 == 1
			@player_1 = Human.new('X')

		elsif input1 == 2
			@player_1 = Sequential.new('X')

		elsif input1 == 3
			@player_1 = RandomAI.new('X')

		else
			puts "Invalid input."
			get_player_1
		end
	end

	def get_player_2
		puts """
		Please select player 2 by entering a number below.
		1 - Human
		2 - Sequential Computer
		3 - Random Computer
		"""

		@input2 = gets.chomp.to_i

		if input2 == 1
			@player_2 = Human.new('O')

		elsif input2 == 2
			@player_2 = Sequential.new('O')

		elsif input2 == 3
			@player_2 = RandomAI.new('O')

		else
			puts "Invalid input."
			get_player_2
		end
	end
end