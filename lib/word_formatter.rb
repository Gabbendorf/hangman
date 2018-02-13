require_relative 'hangman_rules'

class WordFormatter

  attr_reader :rules

  def initialize(rules)
    @rules = rules
  end

  def format(secret_word)
    secret_word.split("").map {|letter| hide_or_reveal(letter) }.join("")
  end

  private

  def hide_or_reveal(letter)
    if not_guessed?(letter)
      "_"
    else
      letter
    end
  end

  def not_guessed?(letter)
    !rules.right_guesses.include?(letter)
  end
end
