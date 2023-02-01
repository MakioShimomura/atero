class GamesController < ApplicationController
  
  def edit
    @question = Question.order("RANDOM()").limit(1)[0]
    correct_answer = Answer.find(@question.answer_id)
    wrong_answers = Answer.order("RANDOM()").limit(3) 
    @answers = wrong_answers.map { |answer| {text: answer.text, is_correct: false} }
    @answers << { text: correct_answer.text, is_correct: true}
    @answers.shuffle!
  end

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
  
  private
    def game_params
      params.require(:game).permit(:name)
    end
end
