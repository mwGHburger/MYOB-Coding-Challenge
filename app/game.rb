class Game
    attr_accessor :empty_spot, :board, :turn_count
    def initialize
        @empty_spot = "."
        @board = [
            [@empty_spot,@empty_spot,@empty_spot],
            [@empty_spot,@empty_spot,@empty_spot],
            [@empty_spot,@empty_spot,@empty_spot]
        ]
        @turn_count = 0
    end
end
