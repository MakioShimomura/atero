class ResultsController < ApplicationController

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