require 'spec_helper'
require_relative '../lib/hangman_rules'

RSpec.describe HangmanRules do

  let(:words) {Words.new}

  it "returns a random word" do
    hangman_rules = new_hangman_rules(WordsStub.new)

    word = hangman_rules.random_word()

    expect(word).to eq("hello")
  end

  it "stores letters correctly guessed" do
    hangman_rules = new_hangman_rules(words)

    hangman_rules.keep_track_of_guesses("hello", "h")
    hangman_rules.keep_track_of_guesses("hello", "e")

    expect(hangman_rules.right_guesses).to eq(["h", "e"])
  end

  it "does not store letter not correctly guessed" do
    hangman_rules = new_hangman_rules(words)

    hangman_rules.keep_track_of_guesses("hello", "c")

    expect(hangman_rules.right_guesses).not_to include("c")
  end

  it "removes letter guessed from guessable letters" do
    hangman_rules = new_hangman_rules(words)

    hangman_rules.keep_track_of_guesses("hello", "a")

    expect(hangman_rules.get_letters()).not_to include("a")
  end

   it "returns all letters of alphabet" do
    hangman_rules = new_hangman_rules(words)

    alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

    expect(hangman_rules.get_letters).to eq(alphabet)
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
