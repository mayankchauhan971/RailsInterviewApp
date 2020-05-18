class Meeting < ApplicationRecord
  belongs_to :user
  has_one_attached :resume
end
