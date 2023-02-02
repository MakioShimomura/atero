class RenameAnswerIdToQuestions < ActiveRecord::Migration[7.0]
  def change
    remove_reference :questions, :answer
    add_reference :questions, :choice, null: false, foreign_key: true
  end
end
