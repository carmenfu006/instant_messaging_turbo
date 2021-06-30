class Board < ApplicationRecord
  has_many :pins, dependent: :destroy

  validates :name, presence: true
end