require 'sinatra'
require_relative 'lib/hangman_rules'
require_relative 'lib/word_generator'
require_relative 'lib/words'
require_relative 'lib/word_formatter'

class App < Sinatra::Base

  enable :sessions

  helpers do

    def rules
      HangmanRules.new(secret_word, guesses)
    end

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

    def guesses
      if session[:guesses].nil?
	session[:guesses] = {:right_guesses => [], :wrong_guesses => []}
      end
      session[:guesses]
    end

    def images
      ["hangman_0", "hangman_1", "hangman_2", "hangman_3", "hangman_4", "hangman_5", "hangman_6", "hangman_7", "hangman_8", "hangman_9", "hangman_10", "hangman_11", "game_over"]
    end

    def current_image
      if !guesses[:wrong_guesses].empty?
	images[guesses[:wrong_guesses].size]
      else
	images[0]
      end
    end
  end

  get "/" do
    @image = current_image
    @secret_word = WordFormatter.new(rules).format(secret_word)
    @letters = letters.join(" ")
    erb :home
  end

  post "/choose-letter" do
    rules = HangmanRules.new(secret_word, guesses)
    rules.guess(params['letter_chosen'], letters)
    redirect "/"
  end

  run! if $PROGRAM_NAME == __FILE__
end

