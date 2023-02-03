class Game < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
  
  scope :sorted, -> {
    select("*,
            correct_quantities * 100 / question_quantities as correct_rate,
            end_at - created_at as answer_time,
            RANK() OVER(ORDER BY correct_quantities * 100 / question_quantities DESC, end_at - created_at ASC) as rank")
          .where.not(end_at: nil)
  }

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
