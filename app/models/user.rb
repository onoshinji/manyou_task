class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 60 },
  # メールアドレスが正しい形式で入力されているかのバリデーション
  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }
  # 大文字小文字を区別するためにすべて小文字として判定するための破壊的メソッドdowncase!
  before_validation { email.downcase! }
  # 下記は、bcryptをbundle installすると使用可能になるメソッドで、password_digestに暗号化したパスワードを保存してくれるものです。
  has_secure_password
  # ユーザーはポストに対しても　１対多の関係により、hasmanyが必要という解釈。
  #関連するものすべてを消去するためにdependent:destroys
  has_many :tasks, dependent: :destroy
end
