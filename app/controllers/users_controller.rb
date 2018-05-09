class UsersController < ApplicationController
  before_action :must_be_proprietary, only:   [:edit, :update, :show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.gen_token_and_salt
    if @user.save
      log_in_session(@user)
      redirect_to user_path(@user.id)
    else
      flash.now[:danger] =  "Failed to create "+@user.firstname + ", "+@user.errors.full_messages.to_sentence+"."
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if user_params.has_key?(:password) && user_params.has_key?(:password_confirmation)
      @user.password = user_params["password"]
      @user.password_confirmation = user_params["password_confirmation"]
      @user.gen_token_and_salt
      @user.change_password(@user.password)
    end
    if @user.update(user_params)
      flash[:success] = "Profil successfully updated."
      redirect_to user_path(@user.id)
    else
      flash[:danger] =  "Failed to update "+@user.firstname + ", "+@user.errors.full_messages.to_sentence+"."
      redirect_to edit_user_path(@user.id)
    end
  end

  def must_be_proprietary
    @user = User.find_by(id: params[:user_id]) || User.find_by(id: params[:id])
    if @user != current_logged_user
      render_403
    end
  end

  def user_params
    params.require(:user).permit(:firstname, :lastname, :mail, :avatar, :password, :password_confirmation)
  end

end
