# game class
require 'tty-prompt'
require_relative './player.rb'
require_relative './board.rb'

class Game

  def initialize
    @players = []
  end

  def start
    @prompt = TTY::Prompt.new
    system 'clear'
    puts 'Welcome to tic tac toe'
    ask_players_data
    board = Board.new
    board.present_board
  end

  def ask_players_data
    2.times do |n|
      player_name = @prompt.ask("What's your name player#{n + 1}?", default: ENV['USER'])
      board_piece = n == 1 ? 'X' : 'O'
      player = Player.new(player_name, board_piece)
      @players << player
    end
    turn = @prompt.select('Who wants to go first?', @players.map(&:name))
    @current_player = @players.select { |p| p.name == turn }
  end
end
