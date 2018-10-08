class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :account_type, :account 
  end
end
