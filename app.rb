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

  get "/" do
    @secret_word = word_formatter.format(secret_word)
    @letters = letters.join(" ")
    erb :home
  end

  post "/choose-letter" do
    letters.delete(params['letter_chosen'])
    redirect "/"
  end

  run! if $PROGRAM_NAME == __FILE__
end

