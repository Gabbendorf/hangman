class Words

  def get_words()
    words.map {|key, value| value}
  end

  private

  def words()
    {:word_1 => "jazzplayer",
    :word_2 => "yachtsman",
    :word_3 => "wristwatch",
    :word_4 => "microwave",
    :word_5 => "pneumonia",
    :word_6 => "megahertz",
    :word_7 => "buzzer",
    :word_8 => "happiness",
    :word_9 => "gazebo",
    :word_10 => "croquet",
    :word_11 => "zombie",
    :word_12 => "questionnaire",
    :word_13 => "fluorescent",
    :word_14 => "embarrassment",
    :word_15 => "restaurant",
    :word_16 => "hanukkah",
    :word_17 => "millennium",
    :word_18 => "xylophone",
    :word_19 => "hangman",
    :word_20 => "lasagna"}
  end
end
