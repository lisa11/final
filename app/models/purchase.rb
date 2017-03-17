class Purchase < ApplicationRecord
  # Direct associations

  belongs_to :user

  has_many   :uses,
             :dependent => :nullify

  belongs_to :product

  # Indirect associations

  # Validations
  validates :product_id, presence: true, :uniqueness => {:scope => [:open_date, :user_id, :empty]}

  validates :estimated_number_of_uses, :open_date, presence: true

  validates :rating, :allow_blank => true, :numericality => {only_integer: true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 5}

end
