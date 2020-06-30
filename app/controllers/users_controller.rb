class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def new
    #管理者だったばあい
    if current_user.admin?
      @user = User.new
      #ログインしていた一般ユーザーだった場合
    elsif logged_in?
      redirect_to tasks_path, notice: "ログインしている人はユーザー作成できません"
    end
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
        ブラウザのcookieにハッシュ化したユーザーidを保存
      if current_user.admin?
        redirect_to admin_users_path
      else
        session[:user_id] = @user.id
        redirect_to user_path(@user.id), notice: "ユーザー情報を登録しました"
      end
    else
      render :new, notice: "ユーザー登録に失敗したよ"
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "ユーザー情報を更新したやで"
    else
      render :edit
    end
  end
  def show
    current_user
    @user = User.find(params[:id])
    #自分以外のユーザーのページにアクセスした場合、タスク一覧に遷移する
    unless current_user.id == @user.id
      redirect_to tasks_path, notice: "自分以外のタスクは見れません"
    end
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                               :password_confirmation,)
  end
end
