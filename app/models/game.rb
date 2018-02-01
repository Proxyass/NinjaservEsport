class Game < ApplicationRecord
  # Validation
  validates :name, presence: true
  # -----

  has_many :teams
end
