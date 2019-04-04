# game class
require_relative './prompt.rb'
require_relative './player.rb'
require_relative './board.rb'
# game class
class Game
  include Prompt
  DIM = 3
  def initialize
    @board = Board.new
    @game_result = ''
  end

  def start
    system 'clear'
    say 'Welcome to tic tac toe'
    ask_players_data
    play
  end

  private

  def play
    loop do
      @current_player.play
      if end?
        print_result
        exit 0
      else
        change_player
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

  def end?
    if win?(@current_player.board_piece)
      @game_result = "The winner is #{@current_player.name}!!!"
      return true
    elsif @board.is_full?
      @game_result = 'Draw'
      return true
    end
    false
  end

  def win?(piece)
    rows = @board.state.each_slice(DIM).to_a
    rows.any? { |row| row.all? { |p| p == piece } } ||
      rows.transpose.any? { |row| row.all? { |p| p == piece } } ||
      rows.map.with_index.all? { |row, i| row[i] == piece } ||
      rows.map.with_index.all? { |row, i| row[DIM-1-i] == piece }
  end

  def print_result
    @board.print
    say @game_result, color: :bright_green
  end
end
