class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :admin_user?
  def index
    @users = User.all
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
        # ブラウザのcookieにハッシュ化したユーザーidを保存
      redirect_to admin_users_path, notice: "新規ユーザーを作成しました"
    else
      render :new
    end

  end

  def edit
  end
  def update
    if @user.update(user_params)
      redirect_to admin_users_path(@user.id), notice: "ユーザーデータを更新しました"
    else
      render :edit
    end
  end
  def show
    #自分以外のユーザーのページにアクセスした場合、タスク一覧に遷移する
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: 'ユーザーを削除しました'
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
  #ここは管理者画面なので、,adminカラムのデータ変更も許可している
  def user_params
    params.require(:user).permit(:name, :email, :password,
                               :password_confirmation, :admin)
  end
  def admin_user?
    unless current_user.admin == "管理者"
      redirect_to root_path, notice: "あなたは管理者ではありません"
    end
  end
end
