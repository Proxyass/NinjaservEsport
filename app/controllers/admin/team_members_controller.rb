class Admin::TeamMembersController < Admin::BaseAdminController
  before_action :team_must_exist
  before_action :team_member_must_exist,  except: [:index, :new, :create]

  def index
    redirect_to new_admin_team_team_member_path(@team.id)
  end

  def new
    @users = User.all
  end

  def create
    team_members_id = team_member_params[:user_ids]
    begin
      TeamMember.transaction do
        team_members_id.each do |member_id|
          member = TeamMember.new
          member.user = User.find_by(id: member_id)
          member.team = @team
          member.save!
        end
        names = []
        @team.team_members.each do |member|
          names << member.user.firstname.capitalize
        end
        flash[:success] = names.join(", ")+" successfully added to "+@team.name.capitalize
      end
    rescue ActiveRecord::RecordInvalid => invalid
      if invalid.record.user
        flash[:danger] = invalid.record.user.firstname.capitalize+" "+invalid.record.errors.messages[:user].to_sentence
      else
        flash[:danger] = "Error while adding members to "+@team.name.capitalize
      end
    end
    redirect_to new_admin_team_team_member_path(@team.id)
  end

  def delete
  end

  def destroy
    if @member.destroy
      flash[:success] = "User "+@member.user.firstname.capitalize+" successfully deleted from team '"+@member.team.name.capitalize+"''"
      redirect_to teams_path
    else
      flash.now[:danger] =  "Failed to delete "+@member.user.firstname + ", "+@member.errors.full_messages.to_sentence+"."
      render 'delete'
    end
  end

  def team_must_exist
    @team = Team.find_by(id: params[:team_id])
    if !@team
      render_404
    end
  end

  def team_member_must_exist
    @member = TeamMember.find_by(id: params[:id])
    if !@member
      render_404
    end
  end

  def team_member_params
    params.require(:team_member).permit(:user_ids => [])
  end

end
