class QuestionsController < ApplicationController
  before_action :require_admin, only: [:new, :create, :index, :destroy]
  before_action :require_image, only: :choice_predict
  before_action :require_choice_text, only: :create

  def index
    @questions = Question.order(created_at: :desc).page(params[:page]).per(20)
  end

  def new
    if latest_tmp_image
      @labels = ["爬虫類", "カメ", "陸生動物"]
      # @labels = Vision.label_detection(latest_tmp_image)
    end
  end

  def choice_predict
    upload_file = params[:upload_file]
    if upload_file.present?
      FileUtils.mkdir_p(TMP_PATH)
      File.binwrite(TMP_PATH + upload_file.original_filename, File.read(upload_file))
    end
    redirect_to new_question_path
  end

  def create
    @choice = Choice.find_by(text: choice_params[:choice_text])
    @choice = @choice ? @choice : Choice.new(text: choice_params[:choice_text])
    question = @choice.questions.build
    question.image.attach(io: File.open(latest_tmp_image), filename: File.basename(latest_tmp_image))
    if question.save
      FileUtils.rm_rf(Dir.glob("#{TMP_PATH}*"))
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

  private
    def latest_tmp_image
      FileUtils.mkdir_p(TMP_PATH)
      files = Dir.glob("#{TMP_PATH}*")
      files.sort_by { |f| File.ctime(f) }.last
    end

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
      if choice_params[:choice_text].empty?
        redirect_to new_question_path, flash: { danger: '正答選択肢を入力してください' }
      end
    end

    def choice_params
      params.require(:question).permit(:choice_text)
    end
end
