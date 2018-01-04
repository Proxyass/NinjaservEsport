class Admin::TeamsController < Admin::BaseAdminController
  before_action :team_must_exist,   except: [:new, :create]

  def new
    @team = Team.new
    @games = Game.all
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      flash[:success] = "Team "+@team.name.capitalize+" successfully created."
      redirect_to new_admin_team_path
    else
      flash.now[:danger] =  "Failed to create "+@team.name + ", "+@team.errors.full_messages.to_sentence+"."
      render 'new'
    end
  end

  def delete
  end

  def destroy
    if @team.destroy
      flash[:success] = "Team "+@team.name.capitalize+" successfully deleted."
      redirect_to teams_path
    else
      flash.now[:danger] =  "Failed to delete "+@team.name + ", "+@team.errors.full_messages.to_sentence+"."
      render 'delete'
    end
  end

  def team_must_exist
    @team = Team.find_by(id: params[:team_id]) || Team.find_by(id: params[:id])
    if !@team
      render_404
    end
  end


  def team_params
    params.require(:team).permit(:name, :description, :game_id, :logo_url)
  end

end
