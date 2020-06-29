module SessionsHelper
  def current_user
    # 現在ログイン中のユーザーを返す (いる場合)
    # find_byで検索をしているのは、ユーザーIDが存在しない場合、findを使うと例外が返されてしまうため
    @current_user ||= User.find_by(id: session[:user_id])
  end
  def logged_in?
    # ここのcurrent_userは上で定義したものに対してpresent?メソッドを使用している、はず
    # present?メソッドは値が存在していればtrue , そうでなければfalse
    current_user.present?
  end
end
