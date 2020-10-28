class TasksController < ApplicationController
  before_action :task_params, only: [:show]
  def index
    @tasks = Task.all
  end

  def new
  end

  def show
  end

  private

  def task_params
    @task = Task.find(params[:id])
  end
end
