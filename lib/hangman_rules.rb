require_relative 'word_generator'

class HangmanRules

  attr_reader :secret_word, :guesses

  def initialize(secret_word, guesses)
    @secret_word = secret_word
    @guesses = guesses
  end

  def guess(guessed_letter, guessable_letters)
    remember_guess_result(guessed_letter) if good_guess?(guessed_letter)
    remove_from_possible_guesses(guessed_letter, guessable_letters)
  end

  def valid_guess?(guessed_letter)
    secret_word.include?(guessed_letter)
  end

  private

  def good_guess?(guessed_letter)
    acceptable_guess?(guessed_letter) && not_guessed_already?(guessed_letter)
  end

  def acceptable_guess?(guessed_letter)
    acceptable_guesses.include?(guessed_letter)
  end

  def not_guessed_already?(guessed_letter)
      !guesses.values.flatten.include?(guessed_letter)
  end

  def remember_guess_result(guessed_letter)
    if valid_guess?(guessed_letter)
      add_guess(guessed_letter, guesses[:right_guesses])
    else
      add_guess(guessed_letter, guesses[:wrong_guesses])
    end
  end

  def add_guess(guessed_letter, guess_result)
    guess_result.push(guessed_letter)
  end

  def remove_from_possible_guesses(letter_guessed, guessable_letters)
    guessable_letters.delete(letter_guessed)
  end

  def acceptable_guesses
    ("a".."z").to_a
  end
end
