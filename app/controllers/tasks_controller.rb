class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all.order(created_at: :DESC)
    if params[:sort_time_limit].present?
      if params[:sort_time_limit] == 'hurry'
        @tasks = Task.all.order(time_limit: :ASC)
      elsif params[:sort_time_limit] == 'slowly'
        @tasks = Task.all.order(time_limit: :DESC)
      end
    end
      #あいまい検索するための記述
    @tasks = @tasks.where('task_name LIKE ?', "%#{params[:search]}%") if params[:search].present?
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: '新規タスクが追加されました' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'タスク内容を編集しました' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'タスクを削除しました' }
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:task_name, :time_limit, :priority, :content)
    end
end
