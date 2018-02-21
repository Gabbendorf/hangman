require 'spec_helper'
require_relative '../lib/hangman_rules'

RSpec.describe HangmanRules do

  it "remembers letters correctly guessed" do
    guesses = new_guesses
    hangman_rules = new_hangman_rules("hello", guesses)

    hangman_rules.guess("h", guessable_letters)
    hangman_rules.guess("e", guessable_letters)

    expect(guesses[:right_guesses]).to eq(["h", "e"])
  end

  it "remembers letters not correctly guessed" do
    guesses = new_guesses
    hangman_rules = new_hangman_rules("hello", guesses)

    hangman_rules.guess("c", guessable_letters)

    expect(guesses[:wrong_guesses]).to eq(["c"])
  end

  it "does not remember wrong guess if not valid" do
    guesses = new_guesses
    hangman_rules = new_hangman_rules("hi", guesses)

    hangman_rules.guess("3", guessable_letters)

    expect(guesses[:wrong_guesses]).not_to include("3")
  end

  it "does not remember wrong guess if it was already made" do
    guesses = new_guesses
    hangman_rules = new_hangman_rules("hi", guesses)

    hangman_rules.guess("e", guessable_letters)
    hangman_rules.guess("e", guessable_letters)

    expect(guesses[:wrong_guesses]).not_to equal(["e", "e"])
    expect(guesses[:wrong_guesses]).to eq(["e"])
  end

  it "does not remember right guess if it was already made" do
    guesses = new_guesses
    hangman_rules = new_hangman_rules("hi", guesses)

    hangman_rules.guess("i", guessable_letters)
    hangman_rules.guess("i", guessable_letters)

    expect(guesses[:right_guesses]).not_to equal(["i", "i"])
    expect(guesses[:right_guesses]).to eq(["i"])
  end

  it "removes letter guessed from guessable letters" do
    hangman_rules = new_hangman_rules("hello", new_guesses)
    letters = guessable_letters

    hangman_rules.guess("a", letters)

    expect(letters).not_to include("a")
  end

  private

  def new_hangman_rules(word, guesses)
    HangmanRules.new(word, guesses)
  end

  def guessable_letters
    ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
  end

  def new_guesses
    {:right_guesses => [], :wrong_guesses => []}
  end
end
