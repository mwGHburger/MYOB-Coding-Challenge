require_relative 'view'
require_relative 'game'

class Controller
    def initialize(game)
        @game = game
        @view = View.new
        @running = true
        @player_1_turn = true
    end

    def run_game
        @view.welcome_text
        @view.display_board(@game.board)
        while @running
            #determines which player's turn
            input = @player_1_turn ? @view.prompt_player("Player 1") : @view.prompt_player("Player 2")
            # handle input method is called
            action = handle_input(input)
            case action
                when "invalid_input"
                    @view.invalid_input
                    @view.display_board(@game.board)
                when "invalid_input_coordinates"
                    @view.invalid_input_coordinates
                    @view.display_board(@game.board)
                when "quit"
                    return
                when "winner"
                    @view.display_board(@game.board)
                    return
                when "continue_game"
                    @view.display_board(@game.board)
                when "repeat_turn"
            end
            
            # check if draw
            if @game.turn_count == 9
                puts "The match is a draw!"
                @running = false
            end
        end
    end

    private

    # updates the board state
    def update_board(x_coordinate, y_coordinate, player_turn)
        if player_turn && @game.empty_spot == @game.board[x_coordinate][y_coordinate]
            @game.board[x_coordinate][y_coordinate] = "X"
            return true
        elsif @game.empty_spot == @game.board[x_coordinate][y_coordinate]
            @game.board[x_coordinate][y_coordinate] = "O"
            return true
        end
        false
    end

    # checks board state if there is a winner (not the most efficient as we a declaring new local variables each time this method is called)
    def check_for_winner
        top_row = @game.board[0][0] == @game.board[0][1] && @game.board[0][1] == @game.board[0][2] && @game.board[0][0] != "."
        middle_row = @game.board[1][0] == @game.board[1][1] && @game.board[1][1] == @game.board[1][2] && @game.board[1][0] != "."
        bottom_row = @game.board[2][0] == @game.board[2][1] && @game.board[2][1] == @game.board[2][2] && @game.board[2][0] != "."
        first_column =  @game.board[0][0] == @game.board[1][0] && @game.board[1][0] == @game.board[2][0] && @game.board[0][0] != "."
        second_column =  @game.board[0][1] == @game.board[1][1] && @game.board[1][1] == @game.board[2][1] && @game.board[0][1] != "."
        third_column = @game.board[0][2] == @game.board[1][2] && @game.board[1][2] == @game.board[2][2] && @game.board[0][2] != "."
        diagonal_1 = @game.board[0][0] == @game.board[1][1] && @game.board[1][1] == @game.board[2][2] && @game.board[0][0] != "."
        diagonal_2 =  @game.board[2][0] == @game.board[1][1] && @game.board[1][1] == @game.board[0][2] && @game.board[2][0] != "."
        top_row || middle_row || bottom_row || first_column || second_column || third_column || diagonal_1 || diagonal_2 ? true : false
    end

    def handle_input(player_input)
        # using regex to check input validity
        if !player_input.match?(/\d+,\d+|q/) 
            return "invalid_input"
        end

        # handle player quiting
        if player_input =='q'
            @player_1_turn ? @view.player_has_quit("Player 1") : @view.player_has_quit("Player 2")
            return "quit"
        end
        
        coordinates_string = player_input.split(",")
        coordinates_adjusted = coordinates_string.map { |coordinate| coordinate.to_i - 1}

        # check valid coordinates; if values are between 1 and 3
        if  !(0 <= coordinates_adjusted[0] && coordinates_adjusted[0] <= 2 && 0 <= coordinates_adjusted[1] && coordinates_adjusted[1] <= 2)
            return "invalid_input_coordinates"
        end

        # if valid update board
        if update_board(coordinates_adjusted[0], coordinates_adjusted[1], @player_1_turn)
            # check if there is a winner
            check_for_winner ? @view.announce_winner : @view.player_input_success
            # switch players
            @player_1_turn = !@player_1_turn
            @game.turn_count += 1
            return check_for_winner ? "winner" : "continue_game"
        else
            @view.invalid_input_duplicate
            return "repeat_turn"
        end
    end    
end
