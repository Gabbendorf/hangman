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

  it "removes letter guessed from guessable letters" do
    hangman_rules = new_hangman_rules("hello", new_guesses)
    letters = guessable_letters

    hangman_rules.guess("a", letters)

    expect(letters).not_to include("a")
  end

  it "knows when game is over and player won" do
    guesses = new_guesses
    hangman_rules = new_hangman_rules("hi", guesses)

    hangman_rules.guess("h", guessable_letters)
    hangman_rules.guess("i", guessable_letters)

    expect(hangman_rules.game_state).to eq(:won)
  end

  it "does not consider doubles in secret word when checking if won" do
    guesses = new_guesses
    hangman_rules = new_hangman_rules("hh", guesses)

    hangman_rules.guess("h", guessable_letters)

    expect(hangman_rules.game_state).to eq(:won)
  end

  it "knows player lost if they guess 11 times wrongly" do
    guesses = new_guesses
    hangman_rules = new_hangman_rules("hi", guesses)

    guess_wrong_eleven_times(hangman_rules)

    expect(hangman_rules.game_state).to eq(:lost)
  end

  it "knows if game is not over" do
    guesses = new_guesses
    hangman_rules = new_hangman_rules("hi", guesses)

    hangman_rules.guess("h", guessable_letters)

    expect(hangman_rules.game_state).to eq(:ongoing)
  end

  private

  def new_hangman_rules(word, right_guesses)
    HangmanRules.new(word, right_guesses)
  end

  def guessable_letters
    ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
  end

  def new_guesses
    {:right_guesses => [], :wrong_guesses => []}
  end

  def guess_wrong_eleven_times(hangman_rules)
    hangman_rules.guess("e", guessable_letters)
    hangman_rules.guess("f", guessable_letters)
    hangman_rules.guess("a", guessable_letters)
    hangman_rules.guess("b", guessable_letters)
    hangman_rules.guess("c", guessable_letters)
    hangman_rules.guess("d", guessable_letters)
    hangman_rules.guess("g", guessable_letters)
    hangman_rules.guess("z", guessable_letters)
    hangman_rules.guess("q", guessable_letters)
    hangman_rules.guess("w", guessable_letters)
    hangman_rules.guess("p", guessable_letters)
  end
end
