require 'spec_helper'
require_relative '../lib/hangman_rules'

RSpec.describe HangmanRules do

  let(:words) {Words.new}

  it "returns a random word" do
    hangman_rules = new_hangman_rules(WordsStub.new)

    word = hangman_rules.random_word()

    expect(word).to eq("hello")
  end

  it "returns true if guessed letter is good one" do
    hangman_rules = new_hangman_rules(words)

    letter_guessed = hangman_rules.valid_guess?("hello", "h")

    expect(letter_guessed).to be true 
  end

  it "returns false if guessed letter is not good one" do
    hangman_rules = new_hangman_rules(words)

    letter_guessed = hangman_rules.valid_guess?("hello", "c")

    expect(letter_guessed).to be false
  end

  it "returns all letters of alphabet" do
    hangman_rules = new_hangman_rules(words)

    alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

    expect(hangman_rules.get_letters).to eq(alphabet)
  end

  it "removes letter guessed from available letters" do
    hangman_rules = new_hangman_rules(words)

    hangman_rules.remove("a")

    expect(hangman_rules.get_letters()).not_to include("a")
  end

  private

  def new_hangman_rules(words)
    HangmanRules.new(words)
  end
end

  class WordsStub

    def get_words()
      ["hello"]
    end
  end
