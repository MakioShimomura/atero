class Game < ApplicationRecord
  scope :order_by_answer_time, -> { select('*, end_at - created_at as answer_time').order(answer_time: :asc) }
  scope :order_by_correct_answer_rate, -> { select('*, correct_quantities / question_quantities as correct_answer_rate').order(correct_answer_rate: :desc) }
  
  def correct_answers
    "#{correct_quantities}/#{question_quantities}"
  end
  
  def percentage_correct_answers
    calc_result = correct_quantities.to_f / question_quantities.to_f * 100
    calc_result.to_i
  end
  
  def answer_time
    "#{(end_at - created_at).round}"
  end
end
