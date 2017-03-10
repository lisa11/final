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

end
