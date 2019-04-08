require 'tty-prompt'
require_relative './prompt'
# player class
class Player
  include Prompt
  attr_accessor :name, :board_piece
  def initialize(name, board_piece, board)
    @name = name
    @board_piece = board_piece
    @board = board
  end

  def play
    turn_finished = false
    msg = ''
    until turn_finished
      @board.print(@name, msg)
      key = keypress "\nUse the arrows to move the cursor or press enter (return) to select\n"
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
        valid = @board.mark_position(@board_piece)
        msg = 'No valid selection' unless valid
        turn_finished = true if valid
      end
    end
  end
end
