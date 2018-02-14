require 'spec_helper'
require_relative '../lib/hangman_rules'

RSpec.describe HangmanRules do

   it "returns letters still guessable" do
    hangman_rules = new_hangman_rules("hello", "") 

    letters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

    expect(hangman_rules.guessable_letters).to eq(letters)
  end

   it "delets letters guessed" do
     hangman_rules = new_hangman_rules("hello", "a")

     letters = ["b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

     expect(hangman_rules.guessable_letters).to eq(letters)
   end

  private

  def new_hangman_rules(secret_word, guessed_letters)
    HangmanRules.new(secret_word, guessed_letters)
  end
end
