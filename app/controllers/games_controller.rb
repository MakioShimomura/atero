class GamesController < ApplicationController
  before_action :is_session_game_id, only: :edit
  before_action :is_correct_game_id, only: :edit

  def show
    if @game = Game.find_by( id: params[:id] )
      reset_session
    else
      redirect_to root_path
    end
  end

  def new
    @game = Game.new
    @game.name = cookies[:game_name] if cookies[:game_name]
    @games = Game.rank_sorted
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      reset_session
      cookies.permanent[:game_name] = @game.name
      session[:game_id] = @game.id
      redirect_to edit_game_path(@game.id)
    else
      @games = Game.rank_sorted
      flash.now[:danger] = '名前が保存できませんでした（12文字以内）'
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @game = Game.find(params[:id])
    @question = Question.order("RANDOM()").limit(1)[0]
    correct_choice = Choice.find(@question.choice_id)
    wrong_choices = Choice.where.not(id: correct_choice.id).order("RANDOM()").limit(3)
    @choices = wrong_choices.map { |choice| {text: choice.text, is_correct: false} }
    @choices << { text: correct_choice.text, is_correct: true}
    @choices.shuffle!
  end

  def update
    game = Game.find(params[:id])
    game.correct_quantities += 1 if params[:question][:choice] == "true"
    if game.current_question_num == game.question_quantities
      game.end_at = Time.now
      game.save
      redirect_to game_path(game)
    else
      game.current_question_num += 1
      game.save
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
