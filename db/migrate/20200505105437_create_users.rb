class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.text :description
      t.string :email
      t.integer :status
      t.string :total_transaction_sum

      t.timestamps
    end
  end
end
