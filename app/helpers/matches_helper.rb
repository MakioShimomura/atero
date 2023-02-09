module MatchesHelper
  
  def victory_judgment(game, opponent_game)
    if game.correct_answers > opponent_game.correct_answers
      "<div class='result-judgment-text win'>【勝ち】</div>".html_safe
    elsif game.correct_answers < opponent_game.correct_answers
      "<div class='result-judgment-text lose'>【負け】</div>".html_safe
    else
      "<div class='result-judgment-text draw'>【引き分け】</div>".html_safe
    end
  end
end
