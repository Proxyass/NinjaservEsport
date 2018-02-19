class Team < ApplicationRecord
  # Validation
  validates :name, presence: true
  # -----

  # Relations
  belongs_to :game
  has_many :team_members
  has_many :users, through: :team_members
  # -----
end
