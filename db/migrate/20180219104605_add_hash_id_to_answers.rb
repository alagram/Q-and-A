class AddHashIdToAnswers < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :hash_id, :string
    add_index :answers, :hash_id
  end
end
