require 'sinatra'
require_relative 'lib/hangman_rules'
require_relative 'lib/word_generator'
require_relative 'lib/words'
require_relative 'lib/word_formatter'
require_relative 'lib/image_setter'
require_relative 'lib/game'

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
  end

  get "/" do
    @image = ImageSetter.new.current_image(guesses[:wrong_guesses])
    @secret_word = WordFormatter.new(rules).format(secret_word)
    @letters = letters.join(" ")
    erb :home
  end

  post "/play" do
    rules = HangmanRules.new(secret_word, guesses)
    rules.guess(params['letter_chosen'], letters)
    if Game.new(rules).finished?
      redirect "/end-of-game"
    else
      redirect "/"
    end
  end

  get "/end-of-game" do
    rules = HangmanRules.new(secret_word, guesses)
    @secret_word_revealed = secret_word.upcase
    if Game.new(rules).state == :won
      @verdict = "You won!"
      @image = ImageSetter.new.image_for_winner
    else
      @verdict = "You lost!"
      @image = ImageSetter.new.image_for_loser
    end
    erb :game_over
  end

  run! if $PROGRAM_NAME == __FILE__
end
