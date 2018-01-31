class Admin::UsersController < Admin::BaseAdminController
  before_action :user_must_exist,     except: [:index, :new, :create]
  before_action :not_you_jean_dummy,  only:   [:destroy, :unset_admin]

  def index
    @users = User.all
  end

  def delete
  end

  def destroy
    if @user.destroy
      flash[:success] = "User "+@user.firstname.capitalize+" successfully deleted."
      redirect_to teams_path
    else
      flash.now[:danger] =  "Failed to delete "+@user.firstname + ", "+@user.errors.full_messages.to_sentence+"."
      render 'delete'
    end
  end

  def set_admin
    @user.admin = true
    @user.password_confirmation = @user.password
    if @user.save
      flash[:success] =  @user.firstname.capitalize + " is now an administrator."
      redirect_to admin_users_path
    else
      flash[:danger] =  "Failed to promote "+@user.firstname + " as an administrator, "+@user.errors.full_messages.to_sentence+"."
      redirect_to admin_users_path
    end
  end

  def unset_admin
    @user.admin = false
    @user.password_confirmation = @user.password
    if @user.save
      flash[:success] =  @user.firstname.capitalize + " is now a regular user."
      redirect_to admin_users_path
    else
      flash[:danger] =  "Failed to Downgrade "+@user.firstname + " as a normal user, "+@user.errors.full_messages.to_sentence+"."
      redirect_to admin_users_path
    end
  end

  def user_must_exist
    @user = User.find_by(id: params[:user_id]) || User.find_by(id: params[:id])
    if !@user
      render_404
    end
  end

  def not_you_jean_dummy
    @user = User.find_by(id: params[:user_id]) || User.find_by(id: params[:id])
    if @user == current_logged_user
      render_403
    end
  end

  def user_params
    params.require(:user).permit(:firstname,:lastname, :mail, :password, :password_confirmation, :admin)
  end

end
