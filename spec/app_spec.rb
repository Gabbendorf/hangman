ENV['RACK_ENV'] = 'test'

require_relative '../app.rb'
require 'rspec'
require 'rack/test'

RSpec.describe Controller do

  RSpec.configure do |conf|
      conf.include Rack::Test::Methods
  end

  def app
    Controller
  end

  it "displays welcome message in homepage" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include("WELCOME TO HANGMAN GAME")
  end
end
