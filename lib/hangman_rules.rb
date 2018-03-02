require_relative 'word_generator'

class HangmanRules

  attr_reader :secret_word, :guesses

  def initialize(secret_word, guesses)
    @secret_word = secret_word
    @guesses = guesses
  end

  def guess(guessed_letter)
    remember_guess_result(guessed_letter) if valid_guess?(guessed_letter)
  end

  private

  def remember_guess_result(guessed_letter)
    if good_guess?(guessed_letter)
      add_guess(guessed_letter, guesses[:right_guesses])
    else
      add_guess(guessed_letter, guesses[:wrong_guesses])
    end
  end

  def good_guess?(guessed_letter)
    secret_word.include?(guessed_letter)
  end

  def add_guess(guessed_letter, guess_result)
    guess_result.push(guessed_letter)
  end

  def valid_guess?(guessed_letter)
    letter?(guessed_letter) && not_guessed_already?(guessed_letter)
  end

  def letter?(guessed_letter)
    valid_letters.include?(guessed_letter)
  end

  def valid_letters
    ("a".."z").to_a
  end

  def not_guessed_already?(guessed_letter)
      !guesses.values.flatten.include?(guessed_letter)
  end
end
