require_relative 'game'
require_relative 'controller'

# create game instance
game = Game.new
controller = Controller.new(game)
# start game
controller.run_game