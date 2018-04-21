class Admin::TeamMembersController < Admin::BaseAdminController
  before_action :team_must_exist
  before_action :team_member_must_exist,  except: [:index, :new, :create]

  def index
    redirect_to new_admin_team_team_member_path(@team.id)
  end

  def new
    @users = User.all
    @roles = TeamMemberRole.all
  end

  def create
    member = TeamMember.new
    begin
      TeamMember.transaction do
        member.user = User.find_by(id: team_member_params[:id])
        member.team = @team
        member.team_member_role = TeamMemberRole.find_by(id: team_member_params[:role_id])
        member.save!
        flash[:success] = member.user.firstname+" successfully added to "+@team.name.capitalize
      end
    rescue
      member.validate
      flash[:danger] = member.user.firstname.capitalize+" "+member.errors.full_messages.to_sentence
    end
    redirect_to new_admin_team_team_member_path(@team.id)
  end

  def delete
  end

  def destroy
    if @member.destroy
      flash[:success] = "User "+@member.user.firstname.capitalize+" successfully deleted from team '"+@member.team.name.capitalize+"''"
      redirect_to admin_team_team_members_path
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
    params.require(:team_member).permit(:id, :role_id)
  end

end
