class TasksController < ApplicationController
  before_action :task_params, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user
  def index
    if params[:task].present?
      @name = params[:task][:name]
      @status = params[:task][:status]
      @label = params[:task][:label_id]

      if @name.present? && @status.present? && @label.present?
        @tasks = current_user.tasks.search_by_name(@name).search_by_status(@status).search_by_label(@label).page(params[:page]).per(10)
      elsif @name.present? && @status.present?
        @tasks = current_user.tasks.search_by_name(@name).search_by_status(@status).page(params[:page]).per(10)
      elsif @name.present? && @label.present?
        @tasks = current_user.tasks.search_by_name(@name).search_by_label(@label).page(params[:page]).per(10)
      elsif @status.present? && @label.present?
        @tasks = current_user.tasks.search_by_status(@status).search_by_label(@label).page(params[:page]).per(10)
      elsif @name.present?
        @tasks = current_user.tasks.search_by_name(@name).page(params[:page]).per(10)
      elsif @status.present?
        @tasks = current_user.tasks.search_by_status(@status).page(params[:page]).per(10)
      elsif @label.present?
        @tasks = current_user.tasks.search_by_label(@label).page(params[:page]).per(10)
      else
        @tasks = current_user.tasks.all.order(created_at: :desc).page(params[:page]).per(10)
      end
      # if params[:task][:name].present? && params[:task][:status].present?
      #   @tasks = current_user.tasks.search_by_name(params[:task][:name]).search_by_status(params[:task][:status]).page(params[:page]).per(10)
      # elsif params[:task][:name].present?
      #   @tasks = current_user.tasks.search_by_name(params[:task][:name]).page(params[:page]).per(10)
      # elsif params[:task][:status].present?
      #   @tasks = current_user.tasks.search_by_status(params[:task][:status]).page(params[:page]).per(10)
      #
      # elsif params[:task][:label_id].present?
      #   binding.pry
      #   @tasks = @tasks.joins(:labels).where(labels: { id: params[:label_id] })
      # else
      #   @tasks = current_user.tasks.all.order(created_at: :desc).page(params[:page]).per(10)
      # end
    elsif params[:sort_expired]
      @tasks = current_user.tasks.all.order(expired_at: :desc).page(params[:page]).per(10)
    elsif params[:sort_priority]
      @tasks = current_user.tasks.all.order(priority: :asc).page(params[:page]).per(10)
    else
        @tasks = current_user.tasks.all.order(created_at: :desc).page(params[:page]).per(10)
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(set_params)
    @task.user_id = current_user.id
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
    params.require(:task).permit(:name, :description, :expired_at, :status, :priority, { label_ids: [] })
  end

  def task_params
    @task = Task.find(params[:id])
  end
end
