class Admin::SponsorsController < Admin::BaseAdminController
  before_action :sponsor_must_exist,   except: [:index, :new, :create]

  def index
    @sponsors = Sponsor.all
  end

  def new
    @sponsor = Sponsor.new
  end

  def create
    @sponsor = Sponsor.new(sponsor_params)
    if @sponsor.save
      flash[:success] = "Sponsor "+@sponsor.name.capitalize+" successfully created."
      redirect_to admin_sponsors_path
    else
      flash.now[:danger] =  "Failed to create "+@sponsor.name + ", "+@sponsor.errors.full_messages.to_sentence+"."
      render 'new'
    end
  end

  def edit
  end

  def update
    if @sponsor.update(sponsor_params)
      flash[:success] = "Sponsor "+@sponsor.name.capitalize+" successfully updated."
      redirect_to admin_sponsors_path
    else
      flash[:danger] =  "Failed to update "+@sponsor.name + ", "+@sponsor.errors.full_messages.to_sentence+"."
      redirect_to edit_admin_team_path(@sponsor.id)
    end
  end

  def delete
  end

  def destroy
    @sponsor.logo = nil
    if @sponsor.save && @sponsor.destroy
      flash[:success] = "Sponsor "+@sponsor.name.capitalize+" successfully deleted."
      redirect_to admin_sponsors_path
    else
      flash.now[:danger] =  "Failed to delete "+@sponsor.name + ", "+@sponsor.errors.full_messages.to_sentence+"."
      render 'delete'
    end
  end

  def sponsor_must_exist
    @sponsor = Sponsor.find_by(id: params[:sponsor_id]) || Sponsor.find_by(id: params[:id])
    if !@sponsor
      render_404
    end
  end

  def sponsor_params
    params.require(:sponsor).permit(:name, :description,:url, :visible, :in_header, :logo)
  end

end
