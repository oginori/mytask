class UsersController < ApplicationController
  before_action :user_params, only: [:show, :edit, :update, :destroy ]
  def new
    if logged_in?
      redirect_to user_path(current_user.id), notice: "既に登録済みです"
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(set_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    if @user.id == current_user.id
      render :show
    else
      redirect_to tasks_path
    end
  end

  def edit
  end

  def update
    if @user.update(set_params)
      redirect_to user_path(@user.id), notice: "更新しました！"
    else
      render :new
    end
  end

  private
  def set_params
    params.require(:user).permit(:name, :email, :password, :passwprd_confirmation )
  end

  def user_params
    @user = User.find(params[:id])
  end
end
