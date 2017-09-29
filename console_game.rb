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
		