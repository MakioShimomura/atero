class QuestionsController < ApplicationController
  skip_forgery_protection only: :label_detection
  before_action :require_admin, only: [:new, :create, :index, :destroy]
  before_action :require_image, only: :choice_predict
  before_action :require_choice_text, only: :create

  def index
    @questions = Question.order(created_at: :desc).page(params[:page]).per(20)
  end

  def new
  end

  def create
    @choice = Choice.find_by(text: params[:question][:choice_text])
    @choice = @choice ? @choice : Choice.new(text: params[:question][:choice_text])
    question = @choice.questions.build
    question.image.attach(params[:question][:upload_file])
    if question.save
      redirect_to questions_path, flash: { success: '問題を作成しました' }
    else
      flash.now[:danger] = "問題の作成に失敗しました"
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    question = Question.find(params[:id])
    if question.destroy
      redirect_to question_url, flash: { success: '問題を削除しました' }
    else
      redirect_to question_url, flash: { danger: '問題の削除に失敗しました' }
    end
  end

  def label_detection
    render :json => Vision.label_detection(params[:upload_file])
  end

  private
    def require_admin
      redirect_to login_path if !logged_in?
    end

    def require_image
      if params[:upload_file].nil?
        flash.now[:danger] = "画像をアップロードしてください"
        return render 'new', status: :see_other
      end
    end

    def require_choice_text
      if params[:question][:choice_text].empty?
        redirect_to new_question_path, flash: { danger: '正答選択肢を入力してください' }
      end
    end
end
