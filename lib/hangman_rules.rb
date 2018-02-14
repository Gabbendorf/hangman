require_relative 'word_generator'

class HangmanRules

  attr_reader :words, :guessable_letters, :right_guesses, :secret_word

  def initialize(word_generator)
  @word_generator = word_generator
  @guessable_letters = ("a".."z").to_a
  @right_guesses = []
  @secret_word = word_generator.random_word()
  end

  def guess(letter)
    if valid_guess?(letter)
      add_right_guess(letter)
    end
    remove_from_possible_guesses(letter)
  end

  def valid_guess?(guessed_letter)
    secret_word.include?(guessed_letter)
  end

  private

  def add_right_guess(guessed_letter)
    right_guesses.push(guessed_letter)
  end

  def remove_from_possible_guesses(letter_guessed)
    guessable_letters.delete(letter_guessed)
  end
end
