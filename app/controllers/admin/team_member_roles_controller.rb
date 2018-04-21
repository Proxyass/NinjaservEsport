class Admin::TeamMemberRolesController < Admin::BaseAdminController
  before_action :role_must_exist,  except: [:index, :new, :create]

  def index
    @roles = TeamMemberRole.all
  end

  def new
    @role = TeamMemberRole.new
  end

  def create
    @role = TeamMemberRole.new(role_params)
    if @role.save
      flash[:success] = "Role "+@role.name.capitalize+" successfully created."
      redirect_to admin_team_member_roles_path
    else
      flash.now[:danger] =  "Failed to create "+@role.name + ", "+@role.errors.full_messages.to_sentence+"."
      render 'new'
    end
  end

  def edit
  end

  def update
    if @role.update(role_params)
      flash[:success] = "Role "+@role.name.capitalize+" successfully updated."
      redirect_to admin_team_member_roles_path
    else
      flash[:danger] =  "Failed to update "+@role.name + ", "+@role.errors.full_messages.to_sentence+"."
      redirect_to edit_admin_team_member_role_path(@role.id)
    end
  end

  def delete
  end

  def destroy
    if @role.destroy
      flash[:success] = "Role "+@role.name.capitalize+" successfully deleted."
      redirect_to admin_team_member_roles_path
    else
      flash.now[:danger] =  "Failed to delete "+@role.name + ", "+@role.errors.full_messages.to_sentence+"."
      render 'delete'
    end
  end

  def role_must_exist
    @role = TeamMemberRole.find_by(id: params[:team_member_role_id]) || TeamMemberRole.find_by(id: params[:id])
    if !@role
      render_404
    end
  end

  def role_params
    params.require(:team_member_role).permit(:name)
  end

end
