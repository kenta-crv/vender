class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :members
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
