class CreateTeamMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :team_members do |t|
      t.belongs_to :user, index: true
      t.belongs_to :team, index: true
      t.timestamps
    end
  end
end
