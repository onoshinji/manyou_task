class User < ApplicationRecord
  #beforedestroyは他のプログラムとの関係でうまく働かないことがあるので、先頭に持ってくる
  #before_destroyは、戻り値がnilだと作動しないので注意が必要。
  before_destroy :do_not_destroy_admin_user
  validates :name,  presence: true, length: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 60 },
  # メールアドレスが正しい形式で入力されているかのバリデーション
  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }
  # 大文字小文字を区別するためにすべて小文字として判定するための破壊的メソッドdowncase!
  before_validation { email.downcase! }
  # 下記は、bcryptをbundle installすると使用可能になるメソッドで、password_digestに暗号化したパスワードを保存してくれるものです。
  has_secure_password
  # ユーザーはポストに対しても１対多の関係により、hasmanyが必要という解釈。
  #関連するものすべてを消去するためにdependent:destroys
  has_many :tasks, dependent: :destroy
  enum admin: { 管理者: true, 一般ユーザー: false}

  def do_not_destroy_admin_user
    #削除する名前が
    #管理者が1人以下になった場合、管理者を削除できないようにする
    admins = User.select(:admin).pluck(:admin).count("管理者")
      throw(:abort) if admins == 1
    end
end
