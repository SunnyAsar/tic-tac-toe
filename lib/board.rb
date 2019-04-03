require 'tty-prompt'
# board class
class Board
  def initialize
    @state = Array.new(9, '·')
    @cursor = 4
  end

  def print(player_name = 'Test')
    prompt = TTY::Prompt.new(Interrupt: :exit)
    board = [
      "                   ",
      "  ┏━━━━━━━━━━━━━┓  ",
      "  ┃    ╷   ╷    ┃  ",
      "  ┃ #{pp(0)}│#{pp(1)}│#{pp(2)} ┃  ",
      "  ┃╶───┼───┼───╴┃  ",
      "  ┃ #{pp(3)}│#{pp(4)}│#{pp(5)} ┃  ",
      "  ┃╶───┼───┼───╴┃  ",
      "  ┃ #{pp(6)}│#{pp(7)}│#{pp(8)} ┃  ",
      "  ┃    ╵   ╵    ┃  ",
      "  ┗━━━━━━━━━━━━━┛  ",
      "                   "
    ].join("\n")
    system "clear"
    prompt.say "\n  #{player_name.upcase}'s turn", color: :bright_green
    prompt.say board, color: :green
    prompt.say "\n  Use the arrows to move on the board and press enter (return) to select", color: :cyan
  end

  private

  def pp(pos)
    pos == @cursor ? "[#{@state[pos]}]" : " #{@state[pos]} "
  end

  public
  def move_cursor_left
    @cursor -= 1
    case @cursor
    when -1
      @cursor = 2
      break
    when 2
      @cursor = 5
      break
    when 5
      @cursor = 8
      break
    end

  end

  def move_cursor_right
    @cursor += 1
    case @cursor
    when 3
      @cursor = 0
      break
    when 6
      @cursor = 3
      break
    when 9
      @cursor = 6
      break
    end
  end

  def move_cursor_up
    @cursor -= 3
    @cursor += 9 if @cursor < 0
  end

  def move_cursor_down
    @cursor += 3
    @cursor -= 9 if @cursor > 8
  end


end
