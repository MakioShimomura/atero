class GamesController < ApplicationController
  before_action :is_session_game_id, only: :edit
  before_action :is_correct_game_id, only: :edit
  
  def show
    @game = Game.find_by( id: params[:id] )
    if @game
      reset_session
    else
      redirect_to root_path
    end
  end

  def new
    @game = Game.new
    @games = Game.where.not(end_at: nil)
                 .order_by_answer_time
                 .order_by_correct_answer_rate
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

  def update
    game = Game.find(params[:id])

    # 正誤判定
    if params[:question][:choice] == "true"
      game.correct_quantities += 1
    end

    # 最終問題判定
    if session[:question_num] == game.question_quantities
      game.end_at = Time.now
      game.save
      redirect_to game_path(game)
    else
      game.save
      session[:question_num] += 1
      redirect_to edit_game_path
    end
  end

  private
    def game_params
      params.require(:game).permit(:name)
    end
    
    def is_session_game_id
      redirect_to root_path if session[:game_id].nil?
    end
    
    def is_correct_game_id
      redirect_to root_path if session[:game_id] != params[:id].to_i
    end
end
