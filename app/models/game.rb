class Game < ApplicationRecord
  def correct_answers
    "#{correct_quantities}/#{question_quantities}"
  end
  
  def percentage_correct_answers
    calc_result = correct_quantities.to_f / question_quantities.to_f * 100
    calc_result.to_i
  end
end
