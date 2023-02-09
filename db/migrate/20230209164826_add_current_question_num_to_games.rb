class AddCurrentQuestionNumToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :current_question_num, :integer, default: 1, null: false
  end
end
