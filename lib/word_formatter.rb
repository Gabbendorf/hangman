class WordFormatter

  attr_reader :secret_word, :guessed_letters 

  def initialize(secret_word, guessed_letters)
    @secret_word = secret_word
    @guessed_letters = guessed_letters
  end

  def format
    secret_word.split("").map {|letter| hide_or_reveal(letter) }.join(" ")
  end

  private

  def hide_or_reveal(letter)
    not_guessed?(letter) ? "_" : letter
  end

  def not_guessed?(letter)
    !guessed_letters.include?(letter)
  end
end
