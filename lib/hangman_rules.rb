require_relative 'word_generator'

class HangmanRules

  attr_reader :secret_word, :guesses

  def initialize(secret_word, guesses)
    @secret_word = secret_word
    @guesses = guesses
  end

  def guess(guessed_letter, guessable_letters)
    remember_guess_result(guessed_letter)
    remove_from_possible_guesses(guessed_letter, guessable_letters)
  end

  def valid_guess?(guessed_letter)
    secret_word.include?(guessed_letter)
  end

  def game_state
    if word_guessed?
      :won
    elsif chances_to_win_run_out?
      :lost
    else
      :ongoing
    end
  end

  private

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

  def word_guessed?
    guesses[:right_guesses].sort == secret_word.split("").uniq.sort
  end

  def chances_to_win_run_out?
    guesses[:wrong_guesses].size == 11
  end
end
