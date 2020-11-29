class UsersController < ApplicationController
  def new
    if logged_in?
      redirect_to user_path(current_user.id)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    if @user.id == current_user.id
      render :show
    else
      redirect_to tasks_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :passwprd_confirmation )
  end
end
