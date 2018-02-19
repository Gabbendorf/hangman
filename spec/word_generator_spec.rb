require_relative '../lib/word_generator'
require_relative 'words_stub'

RSpec.describe WordGenerator do

  it "picks up a random word" do
    word_generator = WordGenerator.new(WordsStub.new)

    expect(word_generator.random_word).to eq("hello")
  end
end
