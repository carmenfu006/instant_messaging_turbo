class Pin < ApplicationRecord
  belongs_to :board

  has_one_attached :image
end