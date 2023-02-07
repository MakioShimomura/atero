class MatchesController < ApplicationController
  def create
    match = Match.where(status: 0).last
    
    if match.nil?
      match = Match.create(status: 0)
    else
      match.update(status: 1, start_at: Time.now)
    end
    
    game = match.games.create(game_params)
    session[:game_id] = game.id
    session[:question_num] = 1
    redirect_to match_play_path(match.id, game.id)
  end
  
  def play
    @match = Match.find(params[:match_id])
    @game = @match.games.find(params[:game_id])
    @opponent_game = @match.games.where.not(id: params[:game_id]).first
    
    if @opponent_game
      @question = Question.order("RANDOM()").limit(1)[0]
      correct_choice = Choice.find(@question.choice_id)
      wrong_choices = Choice.order("RANDOM()").limit(3)
      @choices = wrong_choices.map { |choice| {text: choice.text, is_correct: false} }
      @choices << { text: correct_choice.text, is_correct: true}
      @choices.shuffle!
    end
  end
  
  def update
    @match = Match.find(params[:match_id])
    @game = @match.games.find(params[:game_id])
    @opponent_game = @match.games.where.not(id: params[:game_id]).first
    
    @game.correct_quantities += 1 if params[:question][:choice] == "true"

    if session[:question_num] == @game.question_quantities
      @game.end_at = Time.now
      @match.update(status: 2) if @opponent_game.end_at
    else
      session[:question_num] += 1
    end
    @game.save
    redirect_to match_play_path(@match.id, @game.id)
  end

  private
    def game_params
      params.require(:match).permit(:name)
    end
end
