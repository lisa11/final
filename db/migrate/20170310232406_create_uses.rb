class CreateUses < ActiveRecord::Migration
  def change
    create_table :uses do |t|
      t.integer :purchase_id
      t.integer :user_id
      t.datetime :date

      t.timestamps

    end
  end
end
