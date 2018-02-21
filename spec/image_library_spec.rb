require 'spec_helper'
require_relative '../lib/image_library'

RSpec.describe ImageLibrary do

  let(:image_library) {ImageLibrary.new}

  it "returns heart image for no wrong guesses yet" do
    wrong_guesses = []
    first_image = "heart"

    expect(image_library.current_image(wrong_guesses)).to eq(first_image)
  end

  it "returns image corresponding to number of wrong guesses" do
    wrong_guesses = [1]
    current_image = "hangman_1"

    expect(image_library.current_image(wrong_guesses)).to eq(current_image)
  end

  it "returns heart image for winning player" do
    winner_image = "heart"

    expect(image_library.image_for_winner).to eq(winner_image)
  end

  it "returns last image for loser player" do
    losing_image = "game_over"

    expect(image_library.image_for_loser).to eq(losing_image)
  end
end
