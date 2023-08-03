# frozen_string_literal: true

class TasksController < ApplicationController
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index
  before_action :load_task!, only: %i[show update destroy]
  before_action :check_authorization!, only: %i[show update destroy]

  def index
    tasks = policy_scope(Task)
    tasks_with_assigned_user = tasks.as_json(include: { assigned_user: { only: %i[name id] } })
    render_json({ tasks: tasks_with_assigned_user })
  end

  def create
    task = current_user.created_tasks.new(task_params)
    task.save!
    render_notice(t("successfully_created", entity: "Task"))
  end

  def show
  end

  def update
    @task.update!(task_params)
    render_notice(t("successfully_updated", entity: "Task"))
  end

  def destroy
    @task.destroy!
    render_json
  end

  private

    def load_task!
      @task = Task.find_by!(slug: params[:slug])
    end

    def check_authorization!
      authorize @task
    end

    def task_params
      params.require(:task).permit(:title, :assigned_user_id)
    end
end
