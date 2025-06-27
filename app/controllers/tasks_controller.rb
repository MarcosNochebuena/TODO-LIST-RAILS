class TasksController < ApplicationController
  before_action :set_task, only: %i[ show update destroy ]

  before_action :authenticate_user!

  # GET /tasks
  def index
    @tasks = current_user.tasks
    render json: TaskSerializer.new(@tasks, is_collection: true).serializable_hash
  end

  # GET /tasks/1
  def show
    render json: TaskSerializer.new(@task).serializable_hash
  end

  # POST /tasks
  def create
    @task = current_user.tasks.new(task_params)
    @task.user = current_user

    if @task.save
      render 'show', status: :created, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      render 'show', status: :ok
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = current_user.tasks.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :description, :status, :user_id)
    end
end
