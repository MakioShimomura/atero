class MatchBroadcastJob < ApplicationJob
  queue_as :default

  def perform(match)
    finished_game = match.games.where.not(end_at: nil).first
    MatchChannel.broadcast_to(match, { status: match.status,
                                       finished_id: finished_game ? finished_game.id : nil })
  end
end
