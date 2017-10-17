require 'sinatra'
enable :sessions
require_relative 'web_game.rb'

get '/' do
	session[:game] = Web_game.new
	erb :index, :locals=>{:game=>session[:game]}
end

post '/index' do
	rad_player_1 = params[:rad_player_1]
	rad_player_2 = params[:rad_player_2]
	redirect '/game?rad_player_1=' + rad_player_1 + '&rad_player_2=' + rad_player_2
end

get '/game' do
	rad_player_1 = params[:rad_player_1]
	rad_player_2 = params[:rad_player_2]

	if rad_player_1 == 1
		session[:player1] = Human.new('X')

	elsif rad_player_1 == 2
		session[:player1] = Sequential.new('X')

	elsif rad_player_1 == 3
		session[:player1] = Random_AI.new('X')

	elsif rad_player_1 == 4
		session[:player1] = Impossible.new('X')
	end

	if rad_player_2 == 1
		session[:player2] = Human.new('O')

	elsif rad_player_1 == 2
		session[:player2] = Sequential.new('O')

	elsif rad_player_1 == 3
		session[:player2] = Random_AI.new('O')

	elsif rad_player_1 == 4
		session[:player2] = Impossible.new('O')
	end

	erb :game, :locals=>{:rad_player_1=>rad_player_1, :rad_player_2=>rad_player_2, :game=>session[:game]}
end