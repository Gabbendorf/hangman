require_relative 'hangman_rules'

class WordFormatter

  attr_reader :rules

  def initialize(rules)
    @rules = rules
  end

  def format(secret_word)
    secret_word.split("").map {|letter| hide_or_reveal(letter) }.join(" ")
  end

  private

  def hide_or_reveal(letter)
    if correctly_guessed?(letter)
      letter
    else
      "_"
    end
  end

  def correctly_guessed?(letter)
    rules.guesses[:right_guesses].include?(letter)
  end
end
