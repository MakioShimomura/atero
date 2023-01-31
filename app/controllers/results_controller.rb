class ResultsController < ApplicationController
  
  def edit
    @question = Question.order("RANDOM()").limit(1)[0]
    correct_answer = Answer.find(@question.answer_id)
    wrong_answers = Answer.order("RANDOM()").limit(3) 
    @answers = wrong_answers.map { |answer| {text: answer.text, is_correct: false} }
    @answers << { text: correct_answer.text, is_correct: true}
  end
end
