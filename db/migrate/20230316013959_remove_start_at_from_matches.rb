class RemoveStartAtFromMatches < ActiveRecord::Migration[7.0]
  def change
    remove_column :matches, :start_at, :datetime
  end
end
