class Admin::GamesController < Admin::BaseAdminController
  before_action :game_must_exist,   except: [:index, :new, :create]

  def index
    @games = Game.all
  end


  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      flash[:success] = "Game "+@game.name.capitalize+" successfully created."
      redirect_to new_admin_game_path
    else
      flash.now[:danger] =  "Failed to create "+@game.name + ", "+@game.errors.full_messages.to_sentence+"."
      render 'new'
    end
  end

  def edit
  end

  def update
    if @game.update(game_params)
      flash[:success] = "Game "+@game.name.capitalize+" successfully updated."
      redirect_to admin_games_path
    else
      flash[:danger] =  "Failed to update "+@game.name + ", "+@game.errors.full_messages.to_sentence+"."
      redirect_to edit_admin_game_path(@game.id)
    end
  end

  def delete
  end

  def destroy
    if @game.destroy
      flash[:success] = "Game "+@game.name.capitalize+" successfully deleted."
      redirect_to admin_games_path
    else
      flash.now[:danger] =  "Failed to delete "+@game.name + ", "+@game.errors.full_messages.to_sentence+"."
      render 'delete'
    end
  end

  def game_must_exist
    @game = Game.find_by(id: params[:game_id]) || Game.find_by(id: params[:id])
    if !@game
      render_404
    end
  end

  def game_params
    params.require(:game).permit(:name, :description, :team_based, :image_url)
  end

end
