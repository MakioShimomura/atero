module GamesHelper
  
  def display_end_at(time)
    format_at = I18n.l time
    format_at.gsub(/ /, '<br>').html_safe
  end
  
  def calc_question_progress(current_num, question_quantities)
    current_num * 100 / question_quantities
  end
  
  # modelで書くともっとシンプルになる
  # def correct_answers
  #   "#{@game.correct_quantities}/#{@game.question_quantities}"
  # end
    
  # def percentage_correct_answers
  #   calc_result = @game.correct_quantities.to_f / @game.question_quantities.to_f * 100
  #   calc_result.to_i
  # end
end
