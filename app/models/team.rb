class Team < ApplicationRecord
  # Validation
  validates :name, presence: true
  # -----
  belongs_to :game
end
