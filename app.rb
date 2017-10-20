require 'sinatra'
require 'pg'
enable :sessions
require_relative 'web_board.rb'
require_relative 'player_classes.rb'
require_relative 'local_env.rb' if File.exist?('./local_env.rb')

db_params = {
    host: ENV['host'],
    port: ENV['port'],
    dbname: ENV['db_name'],
    user: ENV['user'],
    password: ENV['password']
}

db = PG::Connection.new(db_params)

get '/' do
	session[:board] = Board.new
	erb :index, :locals=>{:board=>session[:board]}
end

post '/index' do
	session[:rad_player_1] = params[:rad_player_1]
	session[:rad_player_2] = params[:rad_player_2]
	session[:username1] = params[:username1]
	session[:username2] = params[:username2]
	session[:human1] = 'no'
	session[:human2] = 'no'

	if session[:rad_player_1] == "1"
		session[:player1] = Human.new('X')
		session[:human1] = "yes"

	elsif session[:rad_player_1] == "2"
		session[:player1] = Sequential.new('X')

	elsif session[:rad_player_1] == "3"
		session[:player1] = Random_AI.new('X')

	elsif session[:rad_player_1] == "4"
		session[:player1] = Impossible.new('X')
	end

	if session[:rad_player_2] == "1"
		session[:player2] = Human.new('O')
		session[:human2] = "yes"

	elsif session[:rad_player_2] == "2"
		session[:player2] = Sequential.new('O')

	elsif session[:rad_player_2] == "3"
		session[:player2] = Random_AI.new('O')

	elsif session[:rad_player_2] == "4"
		session[:player2] = Impossible.new('O')
	end

	session[:active_player] = session[:player1]

	if session[:human1] == 'yes'
		redirect '/board'
	else
		redirect '/make_move'
	end
end

get '/board' do
	if session[:active_player] == nil
		redirect '/'
	end

	erb :game, :locals => {player1: session[:player1], player2: session[:player2], active_player: session[:active_player].marker, board: session[:board]}
end

get '/make_move' do
	if session[:active_player] == nil
		redirect '/'
	end

	move = session[:active_player].get_move(session[:board].ttt_board)
	session[:board].update_position(move, session[:active_player].marker)

	redirect '/check_game_state'
end

post '/human_move' do
	move = params[:player_choice].to_i - 1
	
	if session[:board].valid_position?(move)
		session[:board].update_position(move, session[:active_player].marker)
		redirect '/check_game_state'
	else
	 	redirect '/board'
	end
end

get '/check_game_state' do
	if session[:active_player] == nil
		redirect '/'
	end

	if session[:board].winner?(session[:active_player].marker)
		message = "#{session[:active_player].marker} is the winner!"

		if session[:active_player] == session[:player1]
			win_or_lose1 = "win"
			win_or_lose2 = "lose"

		else
			win_or_lose1 = "lose"
			win_or_lose2 = "win"
		end

		erb :the_end, :locals => {board: session[:board], message: message}

		if session[:human1] == "yes"
			db.exec("INSERT INTO tic_tac_toe(name, result_of_game, date_and_time) VALUES('#{session[:username1]}', '#{win_or_lose1}', '#{Date.new}')")
		end

		if session[:human2] == "yes"
			db.exec("INSERT INTO tic_tac_toe(name, result_of_game, date_and_time) VALUES('#{session[:username2]}', '#{win_or_lose2}', '#{Date.new}')")
		end

	
	elsif session[:board].full_board?
		message = "The cat got this one!"	
		erb :the_end, :locals => {board: session[:board], message: message}

		win_or_lose1 = "draw"
		win_or_lose2 = "draw"

		if session[:human1] == "yes"
			db.exec("INSERT INTO tic_tac_toe(name, result_of_game, date_and_time) VALUES('#{session[:username1]}', '#{win_or_lose1}', '#{Date.new}')")
		end

		if session[:human2] == "yes"
			db.exec("INSERT INTO tic_tac_toe(name, result_of_game, date_and_time) VALUES('#{session[:username2]}', '#{win_or_lose2}', '#{Date.new}')")
		end
	
	else
		if session[:active_player] == session[:player1]
			session[:active_player] = session[:player2]
		else
			session[:active_player] = session[:player1]
		end

		if session[:active_player] == session[:player1] && session[:human1] == 'yes' || session[:active_player] == session[:player2] && session[:human2] == 'yes'
			redirect '/board'
		else
			redirect '/make_move'
		end
	end
end

get '/clear_sessions' do
	if session[:active_player] == nil
		redirect '/'
	end

	session[:board] = nil
	session[:active_player] = nil
	session[:human1] = nil
	session[:human2] = nil
	session[:player1_type] = nil
	session[:player2_type] = nil

	redirect '/'
end