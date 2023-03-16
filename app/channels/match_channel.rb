class MatchChannel < ApplicationCable::Channel
  def subscribed
    @match = Match.find(params[:match_id])
    reject if @match.nil?
    stream_for(@match)
  end

  def unsubscribed
  end
end
