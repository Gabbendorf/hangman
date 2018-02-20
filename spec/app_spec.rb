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

    expect(last_response.body).to include("WELCOME TO HANGMAN GAME")
  end

  it "displays lines in place of secret word on homepage" do
    get '/', {}, {'rack.session' => {'secret_word' => "hi"}}

    expect(last_response.body).to include("_ _")
  end

  it "asks to make guess on the homepage" do
    get '/'

    expect(last_response.body).to include("Make a guess")
  end

  it "displays list of letters on the homepage" do
    get '/'

    expect(last_response.body).to include("a b c d e f g h i j k l m n o p q r s t u v w x y z")
  end

  it "displays the heart image corresponding to start of game on homepage" do
    starting_image = "heart"

    get '/'

    expect(last_response.body).to include(starting_image)
  end

  it "deletes guessed letter from guessable letters in play route" do
    get '/'
    post '/play', 'letter_chosen' => 'a'

    follow_redirect!

    expect(last_response.body).to include("b c d e f g h i j k l m n o p q r s t u v w x y z")
  end

  it "displays updated hangman immage if guess is wrong" do
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

  it "displays heart immage if game is over and player won" do
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

  it "displays dead man immage if game is over and player lost" do
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