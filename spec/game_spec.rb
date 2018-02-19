require 'spec_helper'
require_relative '../lib/game'
require_relative '../lib/hangman_rules'

RSpec.describe Game do

  it "returns true if game is finished and there is winner" do
    game = new_game("hi", ["h", "i"], [])

    expect(game.finished?).to eq(true)
  end

  it "returns true if game is finished and there is loser" do
    game = new_game("hi", [], wrong_possible_guesses)

    expect(game.finished?).to eq(true)
  end

  it "returns false if game is not finished" do
    game = new_game("hi", [], [])

    expect(game.finished?).to eq(false)
  end

  it "returns :won if there is winner" do
    game = new_game("hi", ["h", "i"], [])

    expect(game.state).to eq(:won)
  end

  it "returns :lost if there is loser" do
    game = new_game("hi", [], wrong_possible_guesses)

    expect(game.state).to eq(:lost)
  end

  it "does not consider doubles in secret word when checking if won" do
    game = new_game("hh", ["h"], [])

    expect(game.state).to eq(:won)
  end

  it "returns :ongoing if game is not finished" do
    game = new_game("hi", [], [])

    expect(game.state).to eq(:ongoing)
  end

  private

  def new_game(secret_word, right_guesses, wrong_guesses)
    rules = HangmanRules.new(secret_word, guesses(right_guesses, wrong_guesses))
    Game.new(rules)
  end

  def guesses(right_guesses, wrong_guesses)
    {:right_guesses => right_guesses, :wrong_guesses => wrong_guesses}
  end

  def wrong_possible_guesses
    ["e", "f", "a", "b", "c", "d", "g", "z", "q", "w", "p"]
  end
end
