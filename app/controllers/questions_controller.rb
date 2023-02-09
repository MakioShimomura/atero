class QuestionsController < ApplicationController
  before_action :require_admin, only: [:new, :create, :index, :destroy]
  before_action :require_choice_text, only: :create
  # before_action :require_img, only: :create

  def index
    @questions = Question.all
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
    question.image.attach(io: img, filename:'tmp.jpg' )

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
      # 一度だけ使える.readでファイルを取得
      tmp_img = upload_file.read
      # ファイルネームを取得
      file_name = upload_file.original_filename
      # アップロード先のディレクトリ
      upload_dir = Rails.root.join("app", "assets","images","predict")
      # アップロードファイルのフルパス
      upload_file_path = upload_dir + file_name
      # アップロードファイルの書き込み
      File.binwrite(upload_file_path, tmp_img)
    end
    redirect_to questions_predict_path
  end

  private
    def get_labels
      if Dir.glob("#{Rails.root}/app/assets/images/predict/**/*").any?
        eng_labels = Vision.get_labels(image)
        @labels = Deepl.kana(eng_labels)
        # @labels = ["ア","カ","サ"]
      end
    end

    def del_images
       require 'fileutils'
       FileUtils.rm_rf("#{Rails.root}/app/assets/images/predict/.")
    end

    def image
      Dir.glob("#{Rails.root}/app/assets/images/predict/**/*").first
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
