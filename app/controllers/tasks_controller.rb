class TasksController < ApplicationController
  before_action :task_params, only: [:show, :edit, :update]
  def index
    @tasks = Task.all
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

  private

  def set_params
    params.require(:task).permit(:name, :description)
  end

  def task_params
    @task = Task.find(params[:id])
  end
end
