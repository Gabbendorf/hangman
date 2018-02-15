require 'sinatra'
require_relative 'lib/hangman_rules'
require_relative 'lib/word_generator'
require_relative 'lib/words'
require_relative 'lib/word_formatter'

class App < Sinatra::Base

  enable :sessions

  helpers do

    def letters
      if session[:letters].nil?
	session[:letters] = ("a".."z").to_a
      end
      session[:letters]
    end

    def secret_word
      if session[:secret_word].nil?
	session[:secret_word] = WordGenerator.new(Words.new).random_word
      end
      session[:secret_word]
    end

    def right_guesses()
      if session[:right_guesses].nil?
	session[:right_guesses] = []
      end
      session[:right_guesses]
    end

    def rules
      HangmanRules.new(secret_word, right_guesses)
    end

  end

  get "/" do
    @secret_word = WordFormatter.new(rules).format(secret_word)
    @letters = letters.join(" ")
    erb :home
  end

  post "/choose-letter" do
    rules = HangmanRules.new(secret_word, right_guesses)
    rules.guess(params['letter_chosen'], letters)
    redirect "/"
  end

  run! if $PROGRAM_NAME == __FILE__
end

