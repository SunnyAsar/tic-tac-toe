# player class
class Player
  attr_accessor :name, :board_piece
  def initialize(name, board_piece, board)
    @name = name
    @board_piece = board_piece
    @board = board
  end

  def play
    # @TODO here the player is going to interect with te board
  end
end
