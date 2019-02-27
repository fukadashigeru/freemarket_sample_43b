class User < ApplicationRecord
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  has_many :scores
  has_many :likes
  has_many :items, foreign_key: 'saler_id'
  has_many :comments
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile
  validates_associated :profile
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # VALID_KANA_REGEX = /[ァ-ヴ][ァ-ヴー・]*/
  validates :nickname, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :encrypted_password, presence: true
  validates :password, length: { in: 6..128, message: "パスワードは6文字以上128文字以下で入力してください" }
  # validates :last_name, presence: true
  # validates :first_name, presence: true
  # validates :last_name_kana, presence: true, format: { with: VALID_KANA_REGEX , message: "カナで入力してください。" }
  # validates :first_name_kana, presence: true, format: { with: VALID_KANA_REGEX , message: "カナで入力してください。" }
  # validates :birthday, presence: true

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    User.dummy_email(auth),
        password: Devise.friendly_token[0, 20],
        nickname: auth.info.name
      )
    end

    user
  end

  private

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
