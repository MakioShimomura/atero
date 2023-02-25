class ChangeColumnsDefaultToGame < ActiveRecord::Migration[7.0]
  def change
    change_column_default :games, :name, nil
    change_column_default :games, :question_quantities, nil
    add_column :games, :start_at, :datetime, null: false
  end
end
