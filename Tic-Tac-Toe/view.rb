class View
    def welcome_text
        puts "Welcome to Tic Tac Toe!\n\nHere's the current board:\n\n"
    end

    def display_board(board)
        board.each do |row|
            row.each do |coordinate|
                print "#{coordinate} "
            end
            puts "\n"
        end
        puts "\n"
    end

    def prompt_player(player)
        print "#{player} enter a coord x,y to place your X or enter 'q' to give up: "
        gets.chomp
    end

    def player_input_success
        puts "\nMove accepted, here's the current board:\n\n"
    end

    def invalid_input
        puts "\nOh no, your input is not valid. Place enter a coord in the format of x,y or enter 'q' to give up.\n\n"
    end

    def invalid_input_duplicate
        puts "\nOh no, a piece is already at this place! Try again...\n\n"
    end

    def invalid_input_coordinates
        puts "\nOh no, your input is not valid. The coordinate values you entered should be between 1 and 3 or enter 'q' to give up.\n\n"
    end

    def announce_winner
        puts "\nMove accepted, well done you've won the game!\n\n"
    end

    def player_has_quit(player)
        puts "\n#{player} has forfeited the match!"
    end
end