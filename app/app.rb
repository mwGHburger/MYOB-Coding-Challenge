require_relative 'game'
require_relative 'controller'

# create game and controller instances
game = Game.new
controller = Controller.new(game)
# start game
controller.run_game