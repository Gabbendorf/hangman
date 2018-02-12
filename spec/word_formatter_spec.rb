require 'spec_helper'
require_relative '../lib/word_formatter'

RSpec.describe WordFormatter do

  let(:words) {Words.new}
  let(:rules) {HangmanRules.new(words)}
  let(:formatter) {WordFormatter.new(rules)}

  it "returns word showing all lines for no letters guessed" do
    formatted_word = formatter.format("hello")

    expect(formatted_word).to eq("_____")
  end

  it "returns word showing lines and right guessed letters" do
    rules.keep_track_of_guesses("hello", "h")
    rules.keep_track_of_guesses("hello", "e")

    formatted_word = formatter.format("hello")

    expect(formatted_word).to eq("he___")
  end
end
