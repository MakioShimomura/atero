class AddReferencesToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :is_match, :boolean, default: false, null: false
    add_reference :games, :match, foreign_key: true
  end
end
