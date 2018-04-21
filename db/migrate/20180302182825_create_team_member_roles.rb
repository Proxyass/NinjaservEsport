class CreateTeamMemberRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :team_member_roles do |t|
      t.string :name
      t.timestamps
    end
    add_reference :team_members, :team_member_role, index: true
  end
end
