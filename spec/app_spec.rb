ENV['RACK_ENV'] = 'test'

require_relative '../app.rb'
require 'rspec'
require 'rack/test'

RSpec.describe App do

  RSpec.configure do |conf|
      conf.include Rack::Test::Methods
  end

  def app
    App
  end

  it "displays welcome message on the homepage" do
    get '/'

    expect(last_response.body).to include("Guess the word!")
  end

  it "displays lines in place of secret word on homepage" do
    get '/', {}, {'rack.session' => {'secret_word' => "hi"}}

    expect(last_response.body).to include("_ _")
  end

  it "displays the start image corresponding to start of game on homepage" do
    starting_image = "start"

    get '/'

    expect(last_response.body).to include(starting_image)
  end

  it "shows wrong guesses" do
    play("hi", ["x", "o"])

    follow_redirect!

    expect(last_response.body).to include("<p>O X</p>")
  end

  it "displays updated hangman image if guess is wrong" do
    updated_image_for_wrong_guess = "hangman_1"

    play("hi", ["g"])
    follow_redirect!

    expect(last_response.body).to include(updated_image_for_wrong_guess)
  end

  it "shows message for winner on end-of-game route " do
    play("hi", ["h", "i"])
    follow_redirect!

    expect(last_response.body).to include("You won!")
  end

  it "displays heart image if game is over and player won" do
    winning_image = "heart"

    play("hi", ["h", "i"])
    follow_redirect!

    expect(last_response.body).to include(winning_image)
  end

  it "reveals secret word at end of game on end-of-game route" do
    play("hi", ["h", "i"])
    follow_redirect!

    expect(last_response.body).to include("HI")
  end

  it "shows message for loser on end-of-game route" do
    play("hi", eleven_wrong_letters)
    follow_redirect!

    expect(last_response.body).to include("You lost!")
  end

  it "displays dead man image if game is over and player lost" do
    dead_man_image = "game_over"

    play("hi", eleven_wrong_letters)
    follow_redirect!

    expect(last_response.body).to include(dead_man_image)
  end

  it "says 0 games won in /games-won route for no games won yet" do
    get '/games-won'

    expect(last_response.body).to include("You won 0 times")
  end

  it "updates games won message in /games-won route" do
    get '/games-won', {}, {'rack.session' => {'games_won' => 5}}

    expect(last_response.body).to include("You won 5 times")
  end

  it "updates count of won games in session cookie" do
    get '/end-of-game', {}, {'rack.session' => {'secret_word' => "hi", 'guesses' => {:right_guesses => ["h", "i"], :wrong_guesses => []}}}

    expect(last_request.env['rack.session']['games_won']).to eq(1)
  end

  it "resets word session to nil for new game in /play-again route" do
    play("hi", ["h", "i"])

    post 'play-again'

    expect(last_request.env['rack.session']['secret_word']).to eq(nil)
  end

  it "resets guesses session to nil for new game in /play-again route" do
    play("hi", ["h", "i"])

    post 'play-again'

    expect(last_request.env['rack.session']['guesses']).to eq(nil)
  end

  it "resets letters session to nil for new game in /play-again route" do
    play("hi", ["h", "i"])

    post 'play-again'

    expect(last_request.env['rack.session']['letters']).to eq(nil)
  end

  private

  def eleven_wrong_letters
    ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'j', 'k', 'l', 'm']
  end

  def play(secret_word, letters)
    get '/', {}, {'rack.session' => {'secret_word' => secret_word}}
    letters.each do |letter|
      post '/play', 'letter_chosen' => letter
    end
  end
end
