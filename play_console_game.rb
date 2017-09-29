require_relative 'console_game.rb'

game = Console_game.new

game.intro

until game.check_winner || game.board.full_board?
	game.change_player
	game.update_board
	game.display_board
end

if game.check_winner
	puts "#{game.active_player.marker} wins!"
else
	puts "The cat got this one!"
end