class TasksController < ApplicationController
  before_action :set_task, only: [ :show, :update, :destroy ]

  def index
    tasks = current_user.tasks
    render json: {
      data: tasks.map { |task| TaskSerializer.new(task).as_json }
    }
  end

  def show
    render json: {
      data: TaskSerializer.new(@task).as_json
    }
  end

  def create
    task = current_user.tasks.build(task_params)

    if task.save
      ProcessTaskJob.perform_later(task.id)
      render json: {
        data: TaskSerializer.new(task).as_json
      }, status: :created
    else
      render json: {
        message: "Task could not be created.",
        errors: task.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render json: {
        data: TaskSerializer.new(@task).as_json,
        message: "Task was successfully updated."
      }
    else
      render json: {
        message: "Task could not be updated.",
        errors: @task.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    render json: { message: "Task was successfully destroyed." }
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title)
  end
end
