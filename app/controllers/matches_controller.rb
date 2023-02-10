class MatchesController < ApplicationController
  before_action :setting_match, only: [:play, :update]

  def create
    match = Match.where(status: 0).last
    
    if match.nil?
      match = Match.create()
      game = match.games.create(game_params)
    else
      # この順番でないとMatchBroadcastJobにてtransactionのエラーが起こる
      game = match.games.create(game_params)
      match.update(status: 1, start_at: Time.now)
    end

    cookies.permanent[:game_name] = game.name
    redirect_to match_play_path(match.id, game.id)
  end
  
  def play
    @question = Question.order("RANDOM()").first
    correct_choice = Choice.find(@question.choice_id)
    wrong_choices = Choice.order("RANDOM()").limit(3)
    @choices = wrong_choices.map { |choice| {text: choice.text, is_correct: false} }
    @choices << { text: correct_choice.text, is_correct: true}
    @choices.shuffle!
  end
  
  def update
    @game.correct_quantities += 1 if params[:question][:choice] == "true"

    if @game.current_question_num >= @game.question_quantities
      @game.end_at = Time.now
      @match.update(status: 2) if @opponent_game.end_at
    else
      @game.current_question_num += 1
    end
    @game.save
    redirect_to match_play_path(@match.id, @game.id)
  end

  private
  
    def setting_match
      @match = Match.find(params[:match_id])
      @game = @match.games.find(params[:game_id])
      @opponent_game = @match.games.where.not(id: params[:game_id]).first
    end
  
    def game_params
      params.require(:match).permit(:name)
    end
end
