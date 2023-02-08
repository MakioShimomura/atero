class QuestionsController < ApplicationController
  before_action :require_admin, only: [:new, :create, :index, :destroy]
  before_action :require_choice_text, only: :create
  
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
    question = @choice.questions.build#(question_params)
    question.image.attach(params[:question][:image])
    if question.save
      flash[:success] = "問題を作成しました"
      redirect_to questions_path
    else
      flash.now[:danger] = "問題の画像/解答を入力してください"
      render 'new', status: :unprocessable_entity
    end
  end
  
  
  def destroy
    question = Question.find(params[:id]).destroy
    if question.destroyed?
      flash[:success] = "問題を削除しました"
      redirect_to question_url, status: :see_other
    else
      flash[:danger] = "問題を削除できませんでした"
      redirect_to question_url, status: :see_other
    end
  end
  
  private
    def choice_params
      params.require(:question).permit(:choice_text)
    end
    
    def question_params
      params.require(:question).permit(:image)
    end
    
    # adminにログインしていなければ、ログイン画面へ
    def require_admin
      redirect_to login_path if !logged_in?
    end
    
    # 解答は入力されていなければならない
    def require_choice_text
      if choice_params[:choice_text].empty?
        flash.now[:danger] = "問題の画像/解答を入力してください"
        return render 'new', status: :see_other
      end
    end
end
