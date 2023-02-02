class ChangeNameDefaultToGames < ActiveRecord::Migration[7.0]
  def change
    change_column_default :games, :name, from: "名無しさん", to: "名無し"
  end
end
