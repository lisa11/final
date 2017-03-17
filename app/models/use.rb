class Use < ApplicationRecord
  # Direct associations

  belongs_to :user

  belongs_to :purchase,
             :counter_cache => true

  # Indirect associations

  # Validations
  validates :purchase_id, :uniqueness => {:scope => :date}

  validates :date, :presence => true


end
