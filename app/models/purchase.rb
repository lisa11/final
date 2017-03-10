class Purchase < ApplicationRecord
  # Direct associations

  has_many   :uses,
             :dependent => :nullify

  belongs_to :product

  # Indirect associations

  # Validations

end
