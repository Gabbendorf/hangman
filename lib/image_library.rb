class ImageLibrary

  attr_reader :images

  def initialize
    @images = ["start", "hangman_1", "hangman_2", "hangman_3", "hangman_4", "hangman_5", "hangman_6", "hangman_7", "hangman_8", "hangman_9", "hangman_10", "game_over", "heart"]
  end

  def current_image(wrong_guesses)
    if wrongly_guessed?(wrong_guesses)
      images[number_corresponding_to_wrong_guess(wrong_guesses)]
    else
      images.first
    end
  end

  def image_for_winner
    images.last
  end

  def image_for_loser
    images[images.size - 2]
  end

 private

 def wrongly_guessed?(wrong_guesses)
   !wrong_guesses.empty?
 end

 def number_corresponding_to_wrong_guess(wrong_guesses)
   wrong_guesses.size
 end
end
