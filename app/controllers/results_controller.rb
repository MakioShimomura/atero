class ResultsController < ApplicationController
  
  def create
    #送信されたformから、paramsで値をとる
    #DBに問い合わせ
    Number_of_question_quantities = 4
    
    result = Result.new(result_params)
    
    result.question_quantities = Number_of_question_quantities
    
    if result.save
      reset_session
      session[:result_id] = result.id
      redirect_to edit_result_pass(session[:result_id])
    end
    
    
    # - postリクエスト(result contlloerのnewアクション)
    # - DBに問い合わせる
    #     - ニックネーム => ok
    #     - 開始時間 => ok
    #     - 問題数(固定値) => ok
    # - sessionでid, 問題番号を渡す
    #     - resultsテーブル
    # - 回答画面にリダイレクト
  end
  
  private
    def result_params
      params.require(:result).permit(:name)
    end
end
