require_relative 'hangman_rules'
require_relative 'game'

class WordFormatter

  attr_reader :rules, :game

  def initialize(rules, game)
    @rules = rules
    @game = game
  end

  def format(secret_word)
    if game.finished?
      secret_word.upcase
    else
      secret_word.split("").map {|letter| hide_or_reveal(letter) }.join(" ")
    end
  end

  private

  def hide_or_reveal(letter)
    if correctly_guessed?(letter)
      letter.capitalize
    else
      "_"
    end
  end

  def correctly_guessed?(letter)
    rules.guesses[:right_guesses].include?(letter)
  end
end
