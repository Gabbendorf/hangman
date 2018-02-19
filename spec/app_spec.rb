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

  it "displays welcome message in the homepage" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include("WELCOME TO HANGMAN GAME")
  end

  it "asks to make guess in the homepage" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include("Make a guess")
  end

  it "displays list of letters" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include("a b c d e f g h i j k l m n o p q r s t u v w x y z")
  end
end

