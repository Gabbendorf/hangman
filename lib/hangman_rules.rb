require_relative 'words'

class HangmanRules

  attr_reader :words, :available_letters, :right_guesses

  def initialize(words)
  @words = words.get_words()
  @available_letters = ("a".."z").to_a
  @right_guesses = []
  end

  def random_word()
    words.sample()
  end

  def keep_track_of_guesses(secret_word, guessed_letter)
    add_if_right_guess(secret_word, guessed_letter)
    remove(guessed_letter)
  end

  def get_letters()
    available_letters
  end

  private

  def add_if_right_guess(secret_word, guessed_letter)
    if valid_guess?(secret_word, guessed_letter)
      right_guesses.push(guessed_letter)
    end
  end

  def valid_guess?(secret_word, guessed_letter)
    secret_word.include?(guessed_letter)
  end

  def remove(letter_guessed)
    available_letters.delete_if {
      |letter| letter == letter_guessed
    }
  end
end
