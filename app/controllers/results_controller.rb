class ResultsController < ApplicationController
  
  def edit
    @question = Question.order("RANDOM()").limit(1)[0]
    correct_answer = Answer.find(@question.answer_id)
    wrong_answers = Answer.order("RANDOM()").limit(3) 
    @answers = wrong_answers.map { |answer| {text: answer.text, is_correct: false} }
    @answers << { text: correct_answer.text, is_correct: true}
  end

  def new
    @result = Result.new
  end
  
  def create
    result = Result.new(result_params)
    
    result.question_quantities = 4
    
    if result.save
      reset_session
      session[:result_id] = result.id
      redirect_to edit_result_pass(session[:result_id])
    end
  end
  
  private
    def result_params
      params.require(:result).permit(:name)
    end
end
