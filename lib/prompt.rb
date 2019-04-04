require 'tty-prompt'
module Prompt
  @prompt = TTY::Prompt.new(interrupt: :exit)
  KEY_UP = "\e[A".freeze
  KEY_DOWN = "\e[B".freeze
  KEY_LEFT = "\e[D".freeze
  KEY_RIGHT = "\e[C".freeze
  KEY_RETURN = "\r".freeze

  def say(text, *args)
    @prompt.say(text, *args)
  end

  def ask(text, *args)
    @prompt.ask(text, *args)
  end

  def selection(text, *args)
    @prompt.select(text, *args)
  end
end
