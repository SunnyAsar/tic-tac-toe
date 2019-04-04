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
    prompt = TTY::Prompt.new(interrupt: :exit)
    turn_finished = false
    msg = ''
    until turn_finished
      @board.print(@name, msg)
      key = prompt.keypress 'Use the arrows to move the cursor or press enter (return) to select'
      case key
      when KEY_UP
        @board.move_cursor_up
        break
      when KEY_DOWN
        @board.move_cursor_down
        break
      when KEY_LEFT
        @board.move_cursor_left
        break
      when KEY_RIGHT
        @board.move_cursor_right
        break
      when KEY_RETURN
        valid = @bard.mark_position(@board_piece)
        msg = 'No valid selection' unless valid
        turn_finished = true if valid
      end
    end
  end
end
