class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.decimal :trans_amount, precision: 9, scale: 2
      t.integer :user_id
      t.boolean :trans_type
      t.timestamps
    end
  end
end
