class QuestionsController < ApplicationController
  before_action :require_admin, only: [:new, :create, :index, :destroy]
  before_action :require_choice_text, only: :create
  # before_action :require_img, only: :create

  def index
    @questions = Question.all.order(created_at: :desc).page(params[:page]).per(20)
  end

  def new
    get_labels
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
    # question.image.attach(params[:question][:image])
    img = File.open(image)
    question.image.attach(io: img, filename: file_name(image) )

    # ---------仮にここで削除
    del_images
    # -------------

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

  def predict
    # アップロードファイル <- file_field
    upload_file = params[:upload_file]

    if upload_file.present?
      # アップロードファイルのフルパス
      upload_path = path + file_name(upload_file)
      # アップロードファイルの書き込み
      save_to_tmp(upload_file,upload_path)
    end
    redirect_to questions_predict_path
  end

  private
    # tmpへの一時保存
    def save_to_tmp(image,path)
      File.binwrite("#{path}*", File.read(image))
    end

    def file_name(image)
      File.basename(image)
    end

    # 一時アップロード先のtmpパス
    def path
      path = "/tmp/quiz_tmp/"
      FileUtils.mkdir_p(path) unless File.exist?(path)
      path
    end

    # 画像ラベル取得API
    def get_labels
      if !image.nil?
        eng_labels = Vision.get_labels(image)
        @labels = Deepl.kana(eng_labels)
        # @labels = ["ア","カ","サ"]
      end
    end

    # 一時アップロード先のファイル削除
    def del_images
      FileUtils.rm_rf(Dir.glob("#{path}*")) if File.exist?(path)
    end

    # 一時アップロード先の最新ファイル
    def image
      files = Dir.glob("#{path}*")
      files.sort_by { |f| File.ctime(f) }.last
    end

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

    # 画像は選択されていなければならない
    def require_img
      if params[:question][:image].nil?
        flash.now[:danger] = "問題の画像/解答を入力してください"
        return render 'new', status: :see_other
      end
    end
end
