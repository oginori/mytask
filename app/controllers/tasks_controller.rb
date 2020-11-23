class TasksController < ApplicationController
  before_action :task_params, only: [:show, :edit, :update, :destroy]
  def index
    if params[:task].present?
      if params[:task][:name].present? && params[:task][:status].present?
        @tasks = Task.search_by_name(params[:task][:name]).search_by_status(params[:task][:status])
      elsif params[:task][:name].present?
        @tasks = Task.search_by_name(params[:task][:name])
      elsif params[:task][:status].present?
        @tasks = Task.search_by_status(params[:task][:status])
      else
        @tasks = Task.all.order(created_at: :desc)
      end
    elsif params[:sort_expired]
      @tasks = Task.all.order(expired_at: :desc)
    elsif params[:sort_priority]
      @tasks = Task.all.order(priority: :asc)
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
    params.require(:task).permit(:name, :description, :expired_at, :status, :priority)
  end

  def task_params
    @task = Task.find(params[:id])
  end
end
