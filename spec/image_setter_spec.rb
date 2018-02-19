require 'spec_helper'
require_relative '../lib/image_setter'

RSpec.describe ImageSetter do

  let(:image_setter) {ImageSetter.new}

  it "returns first image for no wrong guesses yet" do
    wrong_guesses = []
    first_image = "hangman_0"

    expect(image_setter.current_image(wrong_guesses)).to eq(first_image)
  end

  it "returns image corresponding to number of wrong guesses" do
    wrong_guesses = [1]
    current_image = "hangman_1"

    expect(image_setter.current_image(wrong_guesses)).to eq(current_image)
  end

  it "returns first image for winning player" do
    winner_image = "hangman_0"

    expect(image_setter.image_for_winner).to eq(winner_image)
  end

  it "returns last image for loser player" do
    losing_image = "game_over"

    expect(image_setter.image_for_loser).to eq(losing_image)
  end
end
