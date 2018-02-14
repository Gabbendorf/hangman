module ControllerHelpers

  def letters
    rules.guessable_letters
  end

  def secret_word
    if session[:secret_word].nil?
      session[:secret_word] = WordGenerator.new(Words.new).random_word
    end
    session[:secret_word]
  end

  def guessed_letters
    if session[:guessed_letters].nil?
      session[:guessed_letters] = []
    end
    session[:guessed_letters]
  end

  def rules
    HangmanRules.new(secret_word, guessed_letters)
  end

  def word_formatter
    WordFormatter.new(secret_word, guessed_letters)
  end
end
