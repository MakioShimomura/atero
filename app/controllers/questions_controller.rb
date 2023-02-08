class QuestionsController < ApplicationController
  # before_action :require_admin, only: [:new, :create, :index, :destroy]
  
  def index
    @questions = Question.all
  end

  def new
  end
  
  def create
    @choice = Choice.find_by(text: choice_params[:choice_text])
    
    # もし、@choice（正解テキスト）の中にテキストがあれば、それを使う。
    if @choice
      @choice
    else
      # 無ければ、新しく作成する
      @choice = Choice.new(text: choice_params[:choice_text])
    end

    question = @choice.questions.build(question_params)
    question.image.attach(params[:question][:image])
    
    if question.save
      redirect_to questions_path
    else
      render 'new'
    end
  end
  
  
  def destroy
    Question.find(params[:id]).destroy
    redirect_to question_url, status: :see_other
  end
  
  private
    def choice_params
      params.require(:question).permit(:choice_text)
    end
    
    def question_params
      params.require(:question).permit(:text, :image)
    end
    
    # adminにログインしていなければ、ログイン画面へ
    def require_admin
      redirect_to login_path if !logged_in?
    end
end
