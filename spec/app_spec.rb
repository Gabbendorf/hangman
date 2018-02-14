ENV['RACK_ENV'] = 'test'

require_relative '../app.rb'
require 'rspec'
require 'rack/test'

RSpec.describe Controller do

  RSpec.configure do |conf|
      conf.include Rack::Test::Methods
  end

  def app
    Sinatra::Application
  end

  it "displays the homepage" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to eq("WELCOME TO HANGMAN GAME")
  end
end
