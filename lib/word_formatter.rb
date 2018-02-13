require_relative 'hangman_rules'

class WordFormatter

  attr_reader :rules

  def initialize(rules)
    @rules = rules
  end

  def format(secret_word)
    formatted_word = secret_word.split("").map do |letter|
      letter = replaced_letter(letter)
    end
    formatted_word.join("")
  end

  private

  def replaced_letter(letter)
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
