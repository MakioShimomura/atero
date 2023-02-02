class ChangeIsNumDefaultOnGames < ActiveRecord::Migration[7.0]
  def change
    change_column_default :games, :correct_quantities, from: nil, to: 0
  end
end
