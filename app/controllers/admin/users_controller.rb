class Admin::UsersController < ApplicationController
  before_action :user_params, only: [:edit, :update, :delete]
  before_action :admin, only: [:new, :index, :show]
  def new
  end

  def index
    @users = User.all
  end

  def edit
  end

  def update
    if @user.admin?
      @user.update_columns(admin: false)
    else
      @user.update_columns(admin: true)
    end
    redirect_to admin_users_path
  end

  def delete
  end

  private

  def admin
    redirect_to tasks_path, notice: "管理者以外はアクセスできません" unless current_user.admin?
  end

  def set_params
    params.require(:user).permit(:name, :email, :password, :passwprd_confirmation, :admin )
  end

  def user_params
    @user = User.find(params[:id])
  end
end
