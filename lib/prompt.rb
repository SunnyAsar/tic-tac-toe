require 'tty-prompt'
# Prompt module to manage IO
module Prompt
  @@prompt = TTY::Prompt.new(interrupt: :exit)
  KEY_UP = "\e[A".freeze
  KEY_DOWN = "\e[B".freeze
  KEY_LEFT = "\e[D".freeze
  KEY_RIGHT = "\e[C".freeze
  KEY_RETURN = "\r".freeze

  def say(*args)
    @@prompt.say(*args)
  end

  def ask(*args)
    @@prompt.ask(*args)
  end

  def selection(*args)
    @@prompt.select(*args)
  end

  def keypress(*args)
    @@prompt.keypress(*args)
  end
end
