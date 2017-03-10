class Brand < ApplicationRecord
  # Direct associations

  has_many   :products,
             :dependent => :nullify

  # Indirect associations

  # Validations

end
