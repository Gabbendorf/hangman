module ControllerHelpers

  def letters
    if session[:letters].nil?
      session[:letters] = rules.guessable_letters
    end
    session[:letters]
  end

  def secret_word
    if session[:secret_word].nil?
      session[:secret_word] = rules.secret_word
    end
    session[:secret_word]
  end

  def rules
    HangmanRules.new(WordGenerator.new(Words.new))
  end

  def word_formatter
    WordFormatter.new(rules)
  end
end
