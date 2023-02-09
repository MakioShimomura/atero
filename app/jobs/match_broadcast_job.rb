class MatchBroadcastJob < ApplicationJob
  queue_as :default

  def perform(match)
    MatchChannel.broadcast_to(match, { change_status: true })
  end
end
