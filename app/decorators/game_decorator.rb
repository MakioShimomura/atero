class GameDecorator < ApplicationDecorator
  delegate_all
  
  def correct_rate
    "#{object.correct_quantities}/#{object.question_quantities}"
  end

  def correct_percentage
    "#{object.correct_quantities * 100 / object.question_quantities}%"
  end
end
