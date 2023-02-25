class ChangeColumnsNotNullAddAdmin < ActiveRecord::Migration[7.0]
  def change
    change_column_null :admins, :email, false
    change_column_null :admins, :password_digest, false
    add_index :admins, :email, unique: true
  end
end
