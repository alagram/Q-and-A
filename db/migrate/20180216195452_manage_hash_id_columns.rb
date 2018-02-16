class ManageHashIdColumns < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :hash_id
    add_column :questions, :hash_id, :string
    add_index :questions, :hash_id
  end
end
