class AddUseCountToPurchases < ActiveRecord::Migration[5.0]
  def change
    add_column :purchases, :uses_count, :integer
  end
end
