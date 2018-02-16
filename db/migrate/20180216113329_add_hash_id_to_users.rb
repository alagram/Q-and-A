class AddHashIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :hash_id, :string
    add_index :users, :hash_id
  end
end
