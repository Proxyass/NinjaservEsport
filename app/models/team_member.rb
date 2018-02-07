class TeamMember < ApplicationRecord
  # Validations
  validates :team, :user, presence: true
  # -----

  # Relations
  belongs_to :team
  belongs_to :user
  # -----
end
