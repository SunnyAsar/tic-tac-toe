# game class
class Game
  require 'tty-prompt'
  require './lib/player.rb'
  require_relative './board.rb'
  def initialize; end
  @current_player
  def start
    welcome
  end

  def welcome
    @prompt = TTY::Prompt.new
    system 'clear'
    puts 'Welcome to tic tac toe'
    player1 = @prompt.ask("What's your name player One?", default: ENV['USER'])
    player2 = @prompt.ask("What's your name player Two?", default: ENV['USER'])
    turn = @prompt.select('Who wants to go first?', [player1, player2])
    @prompt.say " #{turn}' goes first!", color: :cyan
    @player1 = Player.new(player1, 'X')
    @player2 = Player.new(player2, 'O')
    board = Board.new
    board.present_board
  end
end
