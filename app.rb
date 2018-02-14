require 'sinatra'
require_relative 'lib/hangman_rules'
require_relative 'lib/word_generator'
require_relative 'lib/words'
require_relative 'lib/word_formatter'
require_relative 'controller_helpers'

class Controller < Sinatra::Base

  enable :sessions

  helpers ControllerHelpers

  get "/" do
    @secret_word = word_formatter.format
    @letters = letters.join(" ")
    erb :home
  end

  post "/choose-letter" do
    guessed_letters << params["letter_chosen"]
    redirect "/"
  end

  run! if $PROGRAM_NAME == __FILE__
end

