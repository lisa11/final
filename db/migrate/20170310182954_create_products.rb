class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :brand_id
      t.integer :shelf_life
      t.string :skin_type
      t.boolean :skincare
      t.string :skincare_category
      t.boolean :makeup
      t.string :makeup_category
      t.string :image_url

      t.timestamps

    end
  end
end
