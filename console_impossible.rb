class Impossible
	attr_accessor :marker, :opponent#, :center, :corners, :opposite_corners, :diagonals, :edges, :winning_spaces, :fork_spaces, :priorities

	def get_opponent(marker)

        if @marker == 'X'
        	opponent = 'O'
        
        else
            opponent = 'X'
        end
        opponent
    end

	def initialize(marker)
    	@marker = marker
      
    	@opponent = get_opponent(marker)

    	#@center = 4

    	#@corners = [0, 2, 6, 8]

   		#@opposite_corners = { 0 => 8, 8 => 0, 2 => 6, 6 => 2}

    	#@diagonals = [[0, 4, 8], [2, 4, 6]]

    	#@edge_spaces = [[1, 5, 7, 3]]

    	#@winning_spaces = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

    	#@fork_spaces = [[0, 2, 8], [2, 8, 6], [8, 6, 0], [6, 0, 2], [1, 2, 5], [5, 8, 7], [7, 6, 3], [3, 0, 1]]

    	#@priorities = [[0, 1, 2], [0, 2, 1], [1, 2, 0]]
    end

   	def get_win_or_block(ttt_board, player)

    	possible_winning_combos_on_board = [
      	[ttt_board[0], ttt_board[1], ttt_board[2]],
      	[ttt_board[3], ttt_board[4], ttt_board[5]],
      	[ttt_board[6], ttt_board[7], ttt_board[8]],
      	[ttt_board[0], ttt_board[3], ttt_board[6]],
      	[ttt_board[1], ttt_board[4], ttt_board[7]],
      	[ttt_board[2], ttt_board[5], ttt_board[8]],
      	[ttt_board[0], ttt_board[4], ttt_board[8]],
      	[ttt_board[2], ttt_board[4], ttt_board[6]]
        ]
        
        possible_winning_combos = winning_spaces

        move = 10

        possible_winning_combos_on_board.each_with_index do |winning_combo_line, index_position_of_winning_array_set|
            if winning_combo_line.count(player) == 2 && winning_combo_line.count('') == 1
                winning_empty_space = winning_combo_line.index('')
                move = possible_winning_combos[index_position_of_winning_array_set][winning_empty_space]
            else
                move
            end
        end
        move
    end

    def get_force_def(ttt_board, player, opponent)
      
        possible_diag_combos_on_board =  [ 
        [ttt_board[0], ttt_board[4], ttt_board[8]],
        [ttt_board[2], ttt_board[4], ttt_board[6]]
        ]

         possible_diag_combos = diagonals

        move = 10

        possible_diag_combos_on_board.each_with_index do |winning_combo_line, index_position_of_winning_array_set|
            if winning_combo_line.count(player) == 1 && winning_combo_line.count(opponent) == 2
                if ttt_board[1] == ''
                    move = 1

                elsif ttt_board[3] == ''
                    move = 3

                elsif ttt_board[5] == ''
                    move = 5
                
                elsif ttt_board[7] == ''
                    move = 7

                else 
                    move = 10
                end
                     
            else
                move
            end
        end
        move
    end


    def get_opposite_corner(ttt_board, opponent)
        if ttt_board[0] == '' && ttt_board[8] == opponent
            move = 0

        elsif ttt_board[2] == '' && ttt_board[6] == opponent
            move = 2

        elsif ttt_board[6] == '' && ttt_board[2] == opponent
            move = 6

        elsif ttt_board[8] == '' && ttt_board[0] == opponent
            move = 8

        else 
            move = 10
        end
        move
    end

    def get_edge(ttt_board)
        if ttt_board[1] == ''
            move = 1

        elsif ttt_board[3] == ''
            move = 3

        elsif ttt_board[5] == ''
            move = 5
        
        elsif ttt_board[7] == ''
            move = 7

        else 
            move = 10
        end
        move
    end

	def get_corner(ttt_board)
        if 
            ttt_board[0] == ''
            move = 0

        elsif 
            ttt_board[2] == ''
            move = 2

        elsif 
            ttt_board[6] == ''
            move = 6
        
        elsif 
            ttt_board[8] == ''
            move = 8

        else 
            move = 10
        end
        move
    end

	def get_center(ttt_board)
		move = 10
  		if ttt_board[4]== ''
    		move = 4
  		else
    		move
		end
	end


	def get_fork_or_block(ttt_board, player)

        possible_fork_combos_on_board = [
      	[ttt_board[0], ttt_board[2], ttt_board[8]],
      	[ttt_board[2], ttt_board[8], ttt_board[6]],
      	[ttt_board[8], ttt_board[6], ttt_board[0]],
      	[ttt_board[6], ttt_board[0], ttt_board[2]],
      	[ttt_board[1], ttt_board[2], ttt_board[5]],
      	[ttt_board[5], ttt_board[8], ttt_board[7]],
      	[ttt_board[7], ttt_board[6], ttt_board[3]],
      	[ttt_board[3], ttt_board[0], ttt_board[1]]
        ]
        possible_fork_combos = fork_spaces
          
        move = 10

        possible_fork_combos_on_board.each_with_index do |winning_combo_line, index_position_of_winning_array_set|
            if winning_combo_line.count(player) >= 1 && winning_combo_line.count('') == 1
                winning_empty_space = winning_combo_line.index('')
                move = possible_fork_combos[index_position_of_winning_array_set][winning_empty_space]
            else
                move
            end
        end
        move
    end

	def get_win(ttt_board)
        get_win_or_block(ttt_board, @marker)
    end

    def get_block(ttt_board)
        get_win_or_block(ttt_board, @opponent)
    end

    def create_fork(ttt_board)
        get_fork_or_block(ttt_board, @marker)
    end

    def defend(ttt_board)
      	get_force_def(ttt_board, marker, @opponent)
    end

    def block_fork(ttt_board)
        get_fork_or_block(ttt_board, @opponent)
    end

    def center(ttt_board)
        get_center(ttt_board)
    end

    def opp(ttt_board)
      	get_opposite_corner(ttt_board, @opponent)
    end

    def corner(ttt_board)
      	get_corner(ttt_board)
    end

    def edge(ttt_board)
      	get_edge(ttt_board)
    end


    def get_move(ttt_board)
        move = 70

        if get_win(ttt_board) <= 8
            move = get_win(ttt_board)
     
        elsif get_block(ttt_board) <= 8
            move = get_block(ttt_board)
        

        elsif create_fork(ttt_board) <= 8
            move = create_fork(ttt_board)

        elsif
            defend(ttt_board) <= 8
            move = defend(ttt_board)

       elsif block_fork(ttt_board) <= 8
            move = block_fork(ttt_board)

        elsif center(ttt_board) <= 8
            move = center(ttt_board)

        elsif opp(ttt_board) <= 8
            move = opp(ttt_board)

        elsif corner(ttt_board) <= 8
            move = corner(ttt_board)

        elsif edge(ttt_board) <= 8
            move = edge(ttt_board)

        else
            move = ttt_board.index('')
        
        end
        move
    end
end