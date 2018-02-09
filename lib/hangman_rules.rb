class HangmanRules

  attr_reader :words, :available_letters

  def initialize()
  @words = ["jazzplayer", "yachtsman", "wristwatch", "microwave", "pneumonia",
	   "megahertz", "buzzer", "happiness", "gazebo", "croquet", "zombie",
	   "questionnaire", "fluorescent", "embarrassment", "restaurant",
	   "hanukkah", "millennium", "xylophone", "hangman", "lasagna"]
  @available_letters = ("a".."z").to_a
  end

  def random_word()
    words.sample()
  end

  def valid_guess?(secret_word, guessed_letter)
    secret_word.include?(guessed_letter)
  end

  def get_letters()
    available_letters
  end

  def remove(letter_guessed)
    available_letters.delete_if {
      |letter| letter == letter_guessed
    }
  end
end
