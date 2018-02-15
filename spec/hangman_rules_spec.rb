require 'spec_helper'
require_relative '../lib/hangman_rules'

RSpec.describe HangmanRules do

  #it "returns a random word" do
    #hangman_rules = new_hangman_rules(word_generator_stub)

    #expect(hangman_rules.secret_word).to eq("hello")
  #end

  it "remembers letters correctly guessed" do
    hangman_rules = new_hangman_rules("hello", [])

    hangman_rules.guess("h", guessable_letters)
    hangman_rules.guess("e", guessable_letters)

    expect(hangman_rules.right_guesses).to eq(["h", "e"])
  end

  it "does ignore letters not correctly guessed" do
    hangman_rules = new_hangman_rules("hello", [])

    hangman_rules.guess("c", guessable_letters)

    expect(hangman_rules.right_guesses).not_to include("c")
  end

  it "removes letter guessed from guessable letters" do
    hangman_rules = new_hangman_rules("hello", [])
    letters = guessable_letters

    hangman_rules.guess("a", letters)

    expect(letters).not_to include("a")
  end

  private

  def new_hangman_rules(word, right_guesses)
    HangmanRules.new(word, right_guesses)
  end

  def guessable_letters
    ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
  end
end
