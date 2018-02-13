require_relative 'words'

class WordGenerator

  attr_reader :words

  def initialize(words)
    @words = words
  end

  def random_word()
    words.get_words.sample()
  end
end
