require 'tty-prompt'
# board class
class Board
  attr_reader :state
  PLACEHOLDER = '·'
  def initialize
    @state = Array.new(9, PLACEHOLDER)
    @cursor = 4
  end

  def print(player_name = 'Test', msg)
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
    puts msg
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
    when 2
      @cursor = 5
    when 5
      @cursor = 8
    end
  end

  def move_cursor_right
    @cursor += 1
    case @cursor
    when 3
      @cursor = 0
    when 6
      @cursor = 3
    when 9
      @cursor = 6
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

  def mark_position(piece)
    if @state[@cursor] == PLACEHOLDER
      @state[@cursor] = piece
      return true
    end
    false
  end

  def is_full?
    @state.count(PLACEHOLDER).zero?
  end
end
