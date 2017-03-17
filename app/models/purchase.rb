class Purchase < ApplicationRecord
  # Direct associations

  belongs_to :user

  has_many   :uses,
             :dependent => :nullify

  belongs_to :product

  # Indirect associations

  # Validations
  validates :product, presence: true, :uniqueness => {:scope => [:open_date, :user_id, :empty]}
  validates :estimated_number_of_uses, :open_date, presence: true

end
