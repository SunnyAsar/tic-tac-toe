require_relative './prompt.rb'
# board class
class Board
  include Prompt
  def initialize
    @state = Array.new(9, '·')
    @cursor = 4
  end

  def print(player_name = 'Test')
    # prompt = TTY::Prompt.new(Interrupt: :exit)
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
    alert "\n  #{player_name.upcase}'s turn", color: :bright_green
    alert board, color: :green
    alert "\n  Use the arrows to move on the board and press enter (return) to select", color: :cyan
  end

  private

  def pp(pos)
    pos == @cursor ? "[#{@state[pos]}]" : " #{@state[pos]} "
  end
end
