class RemoveStartTimeFromResults < ActiveRecord::Migration[7.0]
  def change
    remove_column :results, :start_time, :datetime
  end
end
