require 'spec_helper'
require_relative '../lib/word_formatter'
require_relative '../lib/hangman_rules'
require_relative '../lib/game'

RSpec.describe WordFormatter do

  let(:rules) {HangmanRules.new("hello", new_guesses)}
  let(:game) {Game.new(rules)}
  let(:formatter) {WordFormatter.new(rules, game)}

  it "reveals word all in upcase if game is over and win" do
    rules.guess("h")
    rules.guess("e")
    rules.guess("l")
    rules.guess("l")
    rules.guess("o")

    formatted_word = formatter.format("hello")

    expect(formatted_word).to eq("HELLO")
  end

  it "reveals word all in upcase if game is over and lost" do
    guess_wrong_11_times

    formatted_word = formatter.format("hello")

    expect(formatted_word).to eq("HELLO")
  end

  it "secret word is hidden at beginning of game" do
    formatted_word = formatter.format("hello")

    expect(formatted_word).to eq("_ _ _ _ _")
  end

  it "reveals correctly guessed letters" do
    rules.guess("h")
    rules.guess("e")

    formatted_word = formatter.format("hello")

    expect(formatted_word).to eq("H E _ _ _")
  end

  it "keeps hidden letters not correctly guessed" do
    rules.guess("i")

    formatted_word = formatter.format("hello")

    expect(formatted_word).to eq("_ _ _ _ _")
  end

  private

  def new_guesses
    {:right_guesses => [], :wrong_guesses => []}
  end

  def guess_wrong_11_times
    wrong_guesses = ["a", "b", "c", "d", "f", "g", "i", "j", "k", "m", "n"]
    wrong_guesses.each {|wrong_guess| rules.guess(wrong_guess)}
  end
end
