require_relative 'hangman_rules'

class Game

  attr_reader :rules

  def initialize(rules)
    @rules = rules
  end

  def finished?
    state == :won || state == :lost
  end

  def state
    if word_guessed?
      :won
    elsif chances_to_win_run_out?
      :lost
    else
      :ongoing
    end
  end

  private

  def word_guessed?
    rules.guesses[:right_guesses].sort == rules.secret_word.split("").uniq.sort
  end

  def chances_to_win_run_out?
    rules.guesses[:wrong_guesses].size == 11
  end

end
