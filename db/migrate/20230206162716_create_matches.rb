class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.integer :status, null: false, default: 0
      t.datetime :start_at

      t.timestamps
    end
  end
end
