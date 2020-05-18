class User < ApplicationRecord
  validates :user_name, presence: true, length: {minimum: 4, maximum: 16}

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :meetings, dependent: :destroy
end
