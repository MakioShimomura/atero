class CreateResults < ActiveRecord::Migration[7.0]
  def change
    create_table :results do |t|
      t.string :name
      t.integer :question_quantities
      t.integer :answer_quantities
      t.datetime :start_time
      t.datetime :finish_time

      t.timestamps
    end
  end
end
