class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :product_id
      t.integer :user_id
      t.integer :rating
      t.text :note
      t.date :open_date
      t.boolean :empty
      t.integer :estimated_number_of_uses

      t.timestamps

    end
  end
end
