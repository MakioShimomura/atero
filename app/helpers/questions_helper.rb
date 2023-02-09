module QuestionsHelper
  def choice_name(choice_id)
    choice = Choice.find_by(id: choice_id)
    return choice.text
  end
end
