class Admin::TeamsController < Admin::BaseAdminController

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

  def team_params
    params.require(:team).permit(:name, :description, :game_id, :logo_url)
  end

end
