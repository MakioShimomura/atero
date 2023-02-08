class Match < ApplicationRecord
  has_many :games
  after_update_commit { MatchBroadcastJob.perform_later self }
end
