class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    # ここでユーザーの認証を行う。ユーザーが存在し、かつパラムスセッションのパスワードを引数にとりauthenticateメソッドを実行する
    if @user && @user.authenticate(params[:session][:password])
      # ブラウザのcookieにハッシュ化したユーザーidを保存
      session[:user_id] = @user.id
      # 個人ユーザーページにリダイレクトする
      # user_pathで引数としてユーザのIDを持たせる
      if @user.admin == '管理者'
        redirect_to admin_users_path, notice: "管理者ページにログインしました"
      else
        redirect_to user_path(@user.id), notice: "ログインしました"
      end
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    # ここはセッションに対してdelete
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end
end
