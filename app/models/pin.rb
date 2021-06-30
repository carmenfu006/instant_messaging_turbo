class Pin < ApplicationRecord
  belongs_to :board

  has_one_attached :image

  validates :image, presence: true
end