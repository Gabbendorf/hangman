require 'spec_helper'
require_relative '../lib/hangman_rules'
require_relative '../lib/word_generator'
require_relative 'word_generator_stub'
require_relative '../lib/words'

RSpec.describe HangmanRules do

  let(:word_generator_stub) {WordGeneratorStub.new}
  let(:words) {Words.new}
  let(:word_generator) {WordGenerator.new(words)}

  it "returns a random word" do
    hangman_rules = new_hangman_rules(word_generator_stub)

    expect(hangman_rules.secret_word).to eq("hello")
  end

  it "remembers letters correctly guessed" do
    hangman_rules = new_hangman_rules(word_generator_stub)

    hangman_rules.guess("h")
    hangman_rules.guess("e")

    expect(hangman_rules.right_guesses).to eq(["h", "e"])
  end

  it "does ignore letters not correctly guessed" do
    hangman_rules = new_hangman_rules(word_generator_stub)

    hangman_rules.guess("c")

    expect(hangman_rules.right_guesses).not_to include("c")
  end

  it "removes letter guessed from guessable letters" do
    hangman_rules = new_hangman_rules(word_generator_stub)

    hangman_rules.guess("a")

    expect(hangman_rules.guessable_letters).not_to include("a")
  end

   it "returns all letters of alphabet" do
    hangman_rules = new_hangman_rules(word_generator)

    alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

    expect(hangman_rules.guessable_letters).to eq(alphabet)
  end

  private

  def new_hangman_rules(word_generator)
    HangmanRules.new(word_generator)
  end
end
