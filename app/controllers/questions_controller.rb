class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def new
  end
  
  def create
    # debugger
    # もし、choiceの中に同じテキストがあれば、それを使う。
    #choice_text = Choice.find_by(text: params[:question][:choice_text])
    # 無ければ、新しく作成する
    # choice_text = Choice.new(text: params[:question][:choice_text])
    
    
    choice = Choice.new(text: choice_params[:choice_text])
    question = choice.questions.build(question_params)
    question.image.attach(params[:question][:image])
    # debugger
    if question.save
      redirect_to questions_path
    else
      render 'new'
    end
  end
  
  def destroy
  end
  
  private
    def choice_params
      params.require(:question).permit(:choice_text)
    end
    
    def question_params
      params.require(:question).permit(:text, :image)
    end
    # def is_admin
    # end
end
