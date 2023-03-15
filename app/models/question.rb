class Question < ApplicationRecord
  belongs_to :choice
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [400, 400]
  end

  def createFourChoices
    wrong_choices = Choice.where.not(id: self.choice.id).order("RANDOM()").limit(3)
    choices = wrong_choices.map { |choice| {text: choice.text, is_correct: false} }
    choices << { text: self.choice.text, is_correct: true}
    choices.shuffle!
  end
end
