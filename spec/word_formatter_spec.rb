require 'spec_helper'
require_relative '../lib/word_formatter'

RSpec.describe WordFormatter do


  it "secret word is hidden at beginning of game" do
    formatted_word = formatter("hello", []).format

    expect(formatted_word).to eq("_ _ _ _ _")
  end

  it "reveals correctly guessed letters" do
    formatted_word = formatter("hello", ["h", "e"]).format

    expect(formatted_word).to eq("h e _ _ _")
  end

  it "keeps hidden letters not correctly guessed" do
    formatted_word = formatter("hello", ["i"]).format

    expect(formatted_word).to eq("_ _ _ _ _")
  end

  private

  def formatter(word, guessed_letters)
    WordFormatter.new(word, guessed_letters)
  end
end
