class User < ApplicationRecord
  # Direct associations

  has_many   :purchases,
             :dependent => :destroy

  has_many   :uses,
             :dependent => :destroy

  # Indirect associations

  has_many   :products,
             :through => :purchases,
             :source => :product

  # Validations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
