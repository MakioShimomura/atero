class MatchesController < ApplicationController
  before_action :setting_match, only: [:play, :update]

  def create
    match = Match.where(status: 0).last
    if match.nil?
      match = Match.create()
    else
      match.update(status: 1, start_at: Time.zone.now)
    end
    game = match.games.create(name: params[:match][:name],
                              start_at: Time.zone.now,
                              question_quantities: 5)
    cookies.permanent[:nickname] = game.name
    redirect_to match_play_path(match.id, game.id)
  end
  
  def play
    @question = Question.order("RANDOM()").first
    @choices = @question.createFourChoices
  end
  
  def update
    @game.correct_quantities += 1 if params[:question][:choice] == "true"

    if @game.current_question_num >= @game.question_quantities
      @game.end_at = Time.zone.now
      @match.update(status: 2) if @opponent_game.end_at
    else
      @game.current_question_num += 1
    end
    @game.save
    redirect_to match_play_path(@match.id, @game.id)
  end

  private
  
    def setting_match
      @match = Match.find(params[:match_id]).decorate
      @game = @match.games.find(params[:game_id]).decorate
      @opponent_game = @match.games.where.not(id: params[:game_id]).first
      @opponent_game = @opponent_game.decorate if @opponent_game
    end
end
