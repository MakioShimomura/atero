class GamesController < ApplicationController
  
  def new
    @game = Game.new
    @games = Game.all.where.not(end_at: nil)
    #@required_time = @games.end_at - @games.created_at
  end
  
  def create
    game = Game.new(game_params)
    
    if game.save
      reset_session
      session[:game_id] = game.id
      session[:question_num] = 1
      redirect_to edit_game_path(game.id)
    else
      render 'new'
    end
  end
  
  def edit
    @question = Question.order("RANDOM()").limit(1)[0]
    correct_choice = Choice.find(@question.choice_id)
    wrong_choices = Choice.order("RANDOM()").limit(3) 
    @choices = wrong_choices.map { |choice| {text: choice.text, is_correct: false} }
    @choices << { text: correct_choice.text, is_correct: true}
    @choices.shuffle!
  end
  
  private
    def game_params
      params.require(:game).permit(:name)
    end
end
