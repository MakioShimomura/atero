class MatchDecorator < ApplicationDecorator
  delegate_all

  def victory_judgment(game)
    opponent_game = object.games.where.not(id: game.id).first
    if game.correct_quantities > opponent_game.correct_quantities
      "<div class='result-judgment-text win'>【勝ち】</div>".html_safe
    elsif game.correct_quantities < opponent_game.correct_quantities
      "<div class='result-judgment-text lose'>【負け】</div>".html_safe
    else
      "<div class='result-judgment-text draw'>【引き分け】</div>".html_safe
    end
  end
end
