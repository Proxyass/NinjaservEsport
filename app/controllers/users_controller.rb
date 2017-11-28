class UsersController < ApplicationController

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

  def user_params
    params.require(:user).permit(:firstname, :lastname, :mail, :password, :password_confirmation)
  end

end
