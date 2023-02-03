class GamesController < ApplicationController

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
    @games = Game.sorted.all()
  end

  def create
    game = Game.new(game_params)

    if game.save
      reset_session
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
end
