class Admin::UsersController < ApplicationController
  before_action :user_params, only: [:edit, :update, :destroy, :show ]
  before_action :admin, only: [:new, :index, :show]


  def index
    @users = User.all.includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(set_params)
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def show
    @tasks = @user.tasks
  end

  def edit
  end

  def update
    if params[:admin_judge].nil?
      if User.where(admin: true).count == 1 && @user.admin == true
        redirect_to edit_admin_user_path(@user.id), notice: "管理者の権限削除はできません"
      else
        @user.update(set_params)
        redirect_to admin_users_path, notice: '更新しました'
      end
    elsif
      if params[:admin_judge] == "true"
        admin_delete_judge
      elsif params[:admin_judge] == "false"
        @user.update_columns(admin: true)
      end
    redirect_to admin_users_path
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: 'ユーザーを削除しました'
    else
      redirect_to admin_users_path, notice: 'ユーザーを削除できませんでした'
    end
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
