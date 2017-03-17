class Product < ApplicationRecord
  # Direct associations

  belongs_to :brand

  has_many   :purchases

  # Indirect associations

  has_many   :users,
             :through => :purchases,
             :source => :user

  # Validations

  validates :product_name, :presence => true, :uniqueness => { :scope => [:brand_id, :sensitive_skin, :skin_type] }

  validates :brand_id, :skin_type, :image_url, presence: true

  validates_presence_of :skincare_category, if: :skincare?

  validates_presence_of :makeup_category, if: :makeup?

  validates :shelf_life, :presence => true, :numericality => {only_integer: true, :greater_than => 0}



end
