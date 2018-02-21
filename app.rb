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

    def letters
      if session[:letters].nil?
	session[:letters] = ("a".."z").to_a
      end
      session[:letters]
    end

    def games_won
      if session[:games_won].nil?
	session[:games_won] = 0
      end
      session[:games_won]
    end

    def update_won_games_count
      games_won
      session[:games_won] += 1
    end

    def display(verdict_message, image)
      @verdict = verdict_message
      @image = image
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
      update_won_games_count
      display("You won!", ImageSetter.new.image_for_winner)
    else
      display("You lost!", ImageSetter.new.image_for_loser)
    end
    erb :game_over
  end

  get "/games-won" do
    @won_games_count = games_won.to_s
    rules = HangmanRules.new(secret_word, guesses)
    if Game.new(rules).finished?
      @page_to_go_back_to = "end-of-game"
      @message = "Would you like to play again?"
    else
      @page_to_go_back_to = "/"
      @message = "Go back"
    end
    erb :games_won
  end

  run! if $PROGRAM_NAME == __FILE__
end
