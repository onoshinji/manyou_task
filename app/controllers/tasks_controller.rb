class TasksController < ApplicationController
  before_action :authenticate_user
  before_action :set_task, only: [:show,:edit,:update,:destroy]
  before_action :ensure_correct_user, only:[:edit,:destroy]
  before_action :current_user_task, only:[:index]
  def index
    # current_userメソッドで、@current_userにログインしているユーザーのデータを渡している
    current_user
    @paginatable_array = Kaminari.paginate_array(@tasks).page(params[:page]).per(8)
    #終了期限でソートするif文
    if params[:sort_time_limit].present?
      if params[:sort_time_limit] == 'hurry'
        @tasks = @current_user.tasks.order(time_limit: :ASC)

      elsif params[:sort_time_limit] == 'slowly'
        @tasks = @current_user.tasks.order(time_limit: :DESC)
      end
    end
    #優先順位でソートするif文
    if params[:sort_priority].present?
      #文字列と数値の違いでif文が動かなかったのでこれからも注意
      if params[:sort_priority] == "2"
        @tasks = @current_user.tasks.order(priority: :DESC)
      elsif params[:sort_priority] == "0"
        @tasks = @current_user.tasks.order(priority: :ASC)
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
    @task = current_user.tasks.build(task_params)

    if @task.save
      redirect_to tasks_path, notice: '新規タスクが追加されました'
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'タスク内容を編集しました'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'タスクを削除しました'
  end

  private
  def current_user_task
    @tasks = @current_user.tasks.order(created_at: :DESC)
  end
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:task_name, :time_limit, :priority, :content, :status)
  end
  # 認証済みユーザーかどうか判断するメソッド
  def authenticate_user
    unless logged_in?
      redirect_to new_session_path
    end
  end

  def ensure_correct_user
    # 現在ログインしているユーザーと投稿者が合っていなければ
    unless current_user.id == @task.user_id #IDと比較する。ユーザーIDと比較する
      redirect_to tasks_path, notice: "あなたが投稿したもの以外は編集、削除できません。"
    end
  end
end
