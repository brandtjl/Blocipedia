class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :type, :account_type
  end
end
