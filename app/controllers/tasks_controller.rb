class TasksController < ApplicationController
  before_action :task_params, only: [:show, :edit, :update, :destroy]
  def index
    if params[:sort_expired]
      @tasks = Task.all.order(expired_at: :desc)
    else
      @tasks = Task.all.order(created_at: :desc)
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(set_params)
    if @task.save
      redirect_to tasks_path, notice: '新規タスクを作成しました！'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(set_params)
      redirect_to tasks_path, notice: '更新しました！'
    else
      render :new
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'タスクを削除しました。'
  end

  private

  def set_params
    params.require(:task).permit(:name, :description, :expired_at)
  end

  def task_params
    @task = Task.find(params[:id])
  end
end
