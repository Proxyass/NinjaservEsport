class TeamMember < ApplicationRecord
  # Validations
  validates :team, :user, presence: true
  validates :user, :uniqueness => {:scope => [:team], :message => "can't be registered multiple times for the same team"}
  # -----

  # Relations
  belongs_to :team
  belongs_to :user
  belongs_to :team_member_role
  # -----
end
