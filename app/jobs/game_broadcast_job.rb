class GameBroadcastJob < ApplicationJob
  queue_as :default

  def perform(game)
    if game.match
      MatchChannel.broadcast_to(game.match, { change_status: false,
                                              game_id: game.id,
                                              progress: render_progress(game) } )
    end
  end
  
  private
  
    def render_progress(game)
      ApplicationController.renderer.render(partial: 'matches/progress', locals: { game: game })
    end
end
