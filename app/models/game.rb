class Game < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
  
  scope :sorted, -> {
    select("*,
            correct_quantities * 100 / question_quantities as correct_rate,
            strftime('%s', end_at) - strftime('%s', created_at) as answer_time")
          .where.not(end_at: nil)
          .order(correct_rate: :desc, answer_time: :asc)
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
