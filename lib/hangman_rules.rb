class HangmanRules

  attr_reader :secret_word, :guessed_letters

  def initialize(secret_word, guessed_letters)
    @secret_word = secret_word
    @guessed_letters = guessed_letters
  end

  def guessable_letters
    ("a".."z").to_a.delete_if { |letter| guessed_letters.include?(letter) }
  end

end
