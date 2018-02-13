require 'spec_helper'
require_relative '../lib/word_formatter'
require_relative 'word_generator_stub'
require_relative '../lib/hangman_rules'

RSpec.describe WordFormatter do

  let(:word_generator_stub) {WordGeneratorStub.new}
  let(:rules) {HangmanRules.new(word_generator_stub)}
  let(:formatter) {WordFormatter.new(rules)}

  it "secret word is hidden at beginning of game" do
    formatted_word = formatter.format("hello")

    expect(formatted_word).to eq("_ _ _ _ _")
  end

  it "reveals correctly guessed letters" do
    rules.guess("h")
    rules.guess("e")

    formatted_word = formatter.format("hello")

    expect(formatted_word).to eq("h e _ _ _")
  end

  it "keeps hidden letters not correctly guessed" do
    rules.guess("i")

    formatted_word = formatter.format("hello")

    expect(formatted_word).to eq("_ _ _ _ _")
  end
end
