class Product < ApplicationRecord
  # Direct associations

  belongs_to :brand

  has_many   :purchases

  # Indirect associations

  has_many   :users,
             :through => :purchases,
             :source => :user

  # Validations

  validates :product_name, :uniqueness => { :scope => [:brand_id, :sensitive_skin, :skin_type] }

  validates :brand_id, :shelf_life, :skin_type, :image_url, :product_name, presence: true
  validates_presence_of :skincare_category, if: :skincare?
  validates_presence_of :makeup_category, if: :makeup?

end
