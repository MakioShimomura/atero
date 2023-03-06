class GameDecorator < ApplicationDecorator
  delegate_all
  
  def correct_rate
    "#{object.correct_quantities}/#{object.question_quantities}"
  end

  def correct_percentage
    "#{object.correct_quantities * 100 / object.question_quantities}%"
  end

  def formatted_end_at
    I18n.localize(object.end_at).gsub(/ /, '<br>').html_safe
  end

  def progress
    object.current_question_num  * 100 / object.question_quantities
  end

end
