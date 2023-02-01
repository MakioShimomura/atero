class RenameColumnsToGames < ActiveRecord::Migration[7.0]
  def change
    rename_column :games, :finish_time, :end_at
    rename_column :games, :answer_quantities, :correct_quantities
  end
end
