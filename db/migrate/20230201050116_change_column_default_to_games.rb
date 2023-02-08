class ChangeColumnDefaultToGames < ActiveRecord::Migration[7.0]
  def change
    change_column_default :games, :question_quantities, from: nil, to: 10
  end
end
