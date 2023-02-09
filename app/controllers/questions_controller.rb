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
    File.delete(image)
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
      tmp_img = upload_file.read
      # アップロードファイルの元の名前
      upload_file_name = "tmp.jpg"  # upload_file.original_filename
      # プロフィール画像を保存するディレクトリー
      upload_dir = Rails.root.join("app", "assets","images","predict")
      # アップロードするファイルのフルパス
      upload_file_path = upload_dir + upload_file_name
      # アップロードファイルの書き込み
      File.binwrite(upload_file_path, tmp_img)
      # 書き込みせずにAPIに渡せるか？
      # @labels = ["ネコ", "ネココ", "ネコココ"] # このラベルをリダイレクト後のビューに渡す

      # tmp.jpgを消す手続き
      # 同時に投稿したときの手続き
      # newのときではなく、labesを格納しておく方法
    end
    redirect_to questions_predict_path
  end
  
  private
    def get_labels
      if File.exist?(image)
        # image = 'app/assets/images/tmp/tmp.jpg'
        # eng_labels = Vision.get_labels(image)
        # @labels = Deepl.kana(eng_labels)
        @labels = ["ア","カ","サ"]
      end
    end
  
  
    def image
      'app/assets/images/predict/tmp.jpg'
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
