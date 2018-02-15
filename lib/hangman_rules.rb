require_relative 'word_generator'

class HangmanRules

  attr_reader :secret_word, :guesses

  def initialize(secret_word, guesses)
    @secret_word = secret_word
    @guesses = guesses
  end

  def guess(letter, guessable_letters)
    if valid_guess?(letter)
      guesses[:right_guesses].push(letter)
    else
      guesses[:wrong_guesses].push(letter)
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
