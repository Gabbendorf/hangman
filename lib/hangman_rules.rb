require_relative 'word_generator'

class HangmanRules

  attr_reader :words, :guessable_letters, :right_guesses, :secret_word

  def initialize(secret_word, right_guesses)
    @secret_word = secret_word
    @right_guesses = right_guesses
  end

  def guess(letter, guessable_letters)
    if valid_guess?(letter)
      add_right_guess(letter)
    end
    remove_from_possible_guesses(letter, guessable_letters)
  end

  def valid_guess?(guessed_letter)
    secret_word.include?(guessed_letter)
  end

  private

  def add_right_guess(guessed_letter)
    right_guesses.push(guessed_letter)
  end

  def remove_from_possible_guesses(letter_guessed, guessable_letters)
    guessable_letters.delete(letter_guessed)
  end
end
