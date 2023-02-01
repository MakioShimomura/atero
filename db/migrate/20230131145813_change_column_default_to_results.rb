class ChangeColumnDefaultToResults < ActiveRecord::Migration[7.0]
  def change
    change_column_default :results, :name, from: nil, to: "名無しさん"
  end
end
