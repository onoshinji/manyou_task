class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all.page(params[:page]).per(9).order(created_at: :DESC)
    #終了期限でソートするif文
    if params[:sort_time_limit].present?
      if params[:sort_time_limit] == 'hurry'
        @tasks = Task.all.order(time_limit: :ASC)

      elsif params[:sort_time_limit] == 'slowly'
        @tasks = Task.all.order(time_limit: :DESC)
      end
    end
    #優先順位でソートするif文
    if params[:sort_priority].present?
      #文字列と数値の違いでif文が動かなかったのでこれからも注意
      if params[:sort_priority] == "2"
        @tasks = Task.all.order(priority: :DESC)
        # 優先順位が中のものは、必要性がないような気がするので、実装しない。
        # 優先順位でソートする時は高か、低のはず
      # elsif params[:sort_priority] == "1"
      #   @tasks = Task.all.find_by(priority: 1)
      elsif params[:sort_priority] == "0"
        @tasks = Task.all.order(priority: :ASC)
      end
    end
    if params[:task_name_search].present? && params[:status_search].to_i >= 0
      @tasks = Task.task_search(params[:task_name_search]).status_search(params[:status_search])
    elsif params[:task_name_search].present?
      @tasks = Task.task_search(params[:task_name_search])
    elsif params[:status_search].present?
      @tasks = Task.status_search(params[:status_search])
    end
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
      params.require(:task).permit(:task_name, :time_limit, :priority, :content, :status)
    end
end
