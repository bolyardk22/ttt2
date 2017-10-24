require 'minitest/autorun'
require_relative 'player_classes.rb'
require_relative 'web_board.rb'

class TestTTT2Web < Minitest::Test

	def test_one_equals_one
		assert_equal(1,1)
	end

	def test_board_returns
        board_variable = Board.new
        assert_equal([1, 2, 3, 4, 5, 6, 7, 8, 9], board_variable.ttt_board)
    end

    def test_update_board_1st_position
        board_variable = Board.new
        board_variable.update_position(0, "X")
        assert_equal(["X", 2, 3, 4, 5, 6, 7, 8, 9], board_variable.ttt_board)
    end

    def test_valid_position_1st_last_position
        board_variable = Board.new
        board_variable.update_position(0, "X")
        board_variable.update_position(8, "O")
        assert_equal(["X", 2, 3, 4, 5, 6, 7, 8, "O"], board_variable.ttt_board)
    end

    def test_everything_full_but_one_spot
        board_variable = Board.new
        board_variable.ttt_board = ["X", "X", "O", "O", "O", "X", "X", "X", 9]
        board_variable.update_position(8, "O")
        assert_equal(["X", "X", "O", "O", "O", "X", "X", "X", "O"], board_variable.ttt_board)
    end

     def test_valid_position
        board_variable = Board.new
        board_variable.ttt_board = ["X", 2, 3, 4, 5, 6, 7, 8, "O"]
        assert_equal(true, board_variable.valid_position?(3))
        assert_equal(false, board_variable.valid_position?(0))        
        assert_equal(true, board_variable.valid_position?(7))
    end

    def test_full_board
        board_variable = Board.new
        board_variable.ttt_board = ["X", "X", "O", "O", "O", "X", "X", "X", "O"]
        assert_equal(true, board_variable.full_board?)
    end

    def test_full_board2
        board_variable = Board.new
        board_variable.ttt_board = ["X", "X", "O", 4, "O", "X", "X", "X", "O"]
        assert_equal(false, board_variable.full_board?)
    end

    def test_win
        board_variable = Board.new
        board_variable.ttt_board = ["X", "X", "X", 4, 5, 6, 7, 8, 9]
        assert_equal(true, board_variable.winner?("X"))
    end

    def test_one_open_spot
        random_variable = Random_AI.new("X")
        assert_equal(8, random_variable.get_move(["X", "O", "X", "X", "X", "X", "X", "X", 9]))
    end

    def test_two_spots
        random_variable = Random_AI.new("X")
        assert_equal(true, [0,1].include?(random_variable.get_move([1, 2, "X", "X", "X", "X", "X", "X", "X"])))
    end

    def test_two_spots2
        random_variable = Random_AI.new("X")
        assert_equal(true, [7,8].include?(random_variable.get_move(["X", "X", "X", "X", "X", "X", "X", 8, 9])))
    end

    def test_for_X
        sequential_variable = Sequential.new("X")
        assert_equal("X", sequential_variable.marker)
    end

    def test_for_first_available_spot
        sequential_variable = Sequential.new("X")
        assert_equal(0, sequential_variable.get_move([1, 2, 3, 4, 5, 6, 7, 8, 9]))
    end

    def test_for_second_available_spot
        sequential_variable = Sequential.new("X")
        assert_equal(1, sequential_variable.get_move(["X", 2, 3, 4, 5, 6, 7, 8, 9]))
    end

    def test_for_third_available_spot
        sequential_variable = Sequential.new("X")
        assert_equal(2, sequential_variable.get_move(["X", "O", 3, 4, 5, 6, 7, 8, 9]))
    end

    
end