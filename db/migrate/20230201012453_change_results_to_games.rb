class ChangeResultsToGames < ActiveRecord::Migration[7.0]
  def change
    rename_table :results, :games
  end
end
