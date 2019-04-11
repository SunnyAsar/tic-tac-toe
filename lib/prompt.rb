require 'tty-prompt'
# Prompt module to manage IO
module Prompt
  PROMPT = TTY::Prompt.new(interrupt: :exit)
  KEY_UP = "\e[A".freeze
  KEY_DOWN = "\e[B".freeze
  KEY_LEFT = "\e[D".freeze
  KEY_RIGHT = "\e[C".freeze
  KEY_RETURN = "\r".freeze

  def say(*args)
    PROMPT.say(*args)
  end

  def ask(*args)
    PROMPT.ask(*args)
  end

  def selection(*args)
    PROMPT.select(*args)
  end

  def keypress(*args)
    PROMPT.keypress(*args)
  end
end
