# game class
require_relative './prompt.rb'
require_relative './player.rb'
require_relative './board.rb'
# game class
class Game
  include Prompt
  def initialize
    @board = Board.new
  end

  def start
    @prompt = TTY::Prompt.new(interrupt: :exit)
    system 'clear'
    alert 'Welcome to tic tac toe'
    ask_players_data
    @board.print
    # play
  end

  def play
    loop do
      @current_player.play
      if win?
        alert "Player #{@current_player.name} won!"
        sleep 2
        exit 0
      else
        change_player
        # say "#{@current_player.name} is playing now"
      end
    end
  end

  def ask_players_data
    players = []
    2.times do |n|
      player_name = ask("What's your name player#{n + 1}?", default: ENV['USER'])
      board_piece = n == 1 ? 'X' : 'O'
      player = Player.new(player_name, board_piece,@board)
      players << player
    end
    turn = selection('Who wants to go first?', players.map(&:name))
    @current_player, @next_player = players
    change_player if @next_player.name == turn
  end

  def change_player
    @current_player, @next_player = @next_player, @current_player
  end

  def win?
    board_state = @borad.state
    true
  end
end
