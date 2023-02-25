class GamesController < ApplicationController
  before_action :check_game_id_in_session, only: :edit

  def show
    @game = Game.find(params[:id]).decorate
  end

  def new
    @game = Game.new(name: cookies[:nickname] || '名無し')
    @games = Game.rank_sorted.limit(20)
  end

  def create
    @game = Game.new(name: params[:game][:name],
                     start_at: Time.zone.now,
                     question_quantities: 5)
    if @game.save
      cookies.permanent[:nickname] = @game.name
      session[:game_id] = @game.id
      redirect_to edit_game_path(@game.id)
    else
      @games = Game.rank_sorted.limit(20)
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
    if game.current_question_num >= game.question_quantities
      game.end_at = Time.zone.now
      game.save
      session[:game_id] = nil
      redirect_to game_path(game)
    else
      game.current_question_num += 1
      game.save
      redirect_to edit_game_path(game.id)
    end
  end

  private

    def check_game_id_in_session
      if session[:game_id].nil? && session[:game_id] != params[:id].to_i
        redirect_to root_path
      end
    end
end
