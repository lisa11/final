class Use < ApplicationRecord
  # Direct associations

  belongs_to :purchase,
             :counter_cache => true

  # Indirect associations

  # Validations

end
