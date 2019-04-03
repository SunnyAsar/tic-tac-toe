# game class
require 'tty-prompt'
require_relative './player.rb'
require_relative './board.rb'
# game class
class Game
  def initialize
    @board = Board.new
  end

  def start
    @prompt = TTY::Prompt.new
    system 'clear'
    puts 'Welcome to tic tac toe'
    ask_players_data
    @board.present_board
  end

  def ask_players_data
    players = []
    2.times do |n|
      player_name = @prompt.ask("What's your name player#{n + 1}?", default: ENV['USER'])
      board_piece = n == 1 ? 'X' : 'O'
      player = Player.new(player_name, board_piece,@board)
      players << player
    end
    turn = @prompt.select('Who wants to go first?', players.map(&:name))
    @current_player, @next_player = players
    change_player if @next_player.name == turn
  end

  def change_player
    @current_player, @next_player = @next_player, @current_player
  end
end
