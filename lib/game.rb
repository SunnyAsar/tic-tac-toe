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
      play_turn(@current_player)
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
      player = Player.new(player_name, board_piece)
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
    if win?(@current_player.board_piece,@board.state)
      @game_result = " The winner is #{@current_player.name}!!!\n"
      return true
    elsif @board.is_full?
      @game_result = " It's a Draw!!!\n"
      return true
    end
    false
  end

  def win?(piece, game_state)
    rows = game_state.each_slice(DIM).to_a
    rows.any? { |row| row.all? { |p| p == piece } } ||
      rows.transpose.any? { |row| row.all? { |p| p == piece } } ||
      rows.map.with_index.all? { |row, i| row[i] == piece } ||
      rows.map.with_index.all? { |row, i| row[DIM - 1 - i] == piece }
  end

  def print_result
		say " #{@board.parse_board} \n"
    say @game_result, color: :bright_green
  end

  def print_board(message: '', parsed_board:, player_name:)
    system 'clear'
    say("\n  #{player_name.upcase}'s turn", color: :bright_green) unless player_name.nil?
    say parsed_board, color: :green
    say("\n #{message}", color: :red)
  end

  def play_turn(player)
    turn_finished = false
    until turn_finished
      print_board(message: @message, parsed_board: @board.parse_board, player_name: player.name)
      key = keypress "\nUse the arrows to move the cursor or press enter (return) to select\n"
      turn_finished = make_move(key, player.board_piece)
    end
  end

  def make_move(key, player_piece)
    case key
    when KEY_UP
      @board.move_cursor_up
    when KEY_DOWN
      @board.move_cursor_down
    when KEY_LEFT
      @board.move_cursor_left
    when KEY_RIGHT
      @board.move_cursor_right
    when KEY_RETURN
      @board.mark_position(player_piece) if valid_move?([@current_player.board_piece, @next_player.board_piece], @board.cursor_value)
    end
  end

  def valid_move?(players_piece, current_board_value)
    have_piece = players_piece.include? current_board_value
    @message = 'Not Valid Move' if have_piece
    !have_piece
  end
end
