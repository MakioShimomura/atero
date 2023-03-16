class Game < ApplicationRecord
  belongs_to :match, optional: true
  validates :name, presence: true, length: { maximum: 12 }
  after_update_commit { GameBroadcastJob.perform_later self }
  
  scope :rank_sorted, -> {
    select("*,
            correct_quantities * 100 / question_quantities AS correct_rate,
            date_trunc('second', end_at - start_at) AS answer_time,
            RANK() OVER(
                ORDER BY correct_quantities * 100 / question_quantities DESC,
                date_trunc('second', end_at - start_at) ASC) AS rank")
          .where.not(end_at: nil)
  }
end
