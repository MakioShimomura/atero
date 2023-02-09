class MatchBroadcastJob < ApplicationJob
  queue_as :default

  def perform(match)
    MatchChannel.broadcast_to(match, { change_status: true })
    
    #game = Game.find(53)
    #game.match で取得可能
  end
end
