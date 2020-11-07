class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  # Validation_definition
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_NAME_REGEX = /\A[ぁ-んァ-ン一-龥]+\z/
  VALID_KANA_REGEX = /\A[ぁ-んー－]+\z/

  # Registrations_validation
  validates :nickname, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true, 
            format: { with: VALID_EMAIL_REGEX, message: "フォーマットが不適切です" }
  validates :encrypted_password, presence: true
  validates :last_name, presence: true, length: { maximum: 30 },
            format: { with: VALID_NAME_REGEX, message: "全角ひらがな、全角カタカナ、漢字で入力してください" }
  validates :first_name, presence: true,  length: { maximum: 30 },
            format: { with: VALID_NAME_REGEX, message: "全角ひらがな、全角カタカナ、漢字で入力してください" }
  validates :last_name_kana, presence: true, length: { maximum: 30 },
            format: { with: VALID_KANA_REGEX, message: "全角ひらがなで入力してください" }
  validates :first_name_kana, presence: true, length: { maximum: 30 },
            format: { with: VALID_KANA_REGEX, message: "全角ひらがなで入力してください" }
  validates :birthday, presence: true

  # Association
  has_one :address
  has_many :selling_items, -> { where("seller_id is not NULL && buyer_id is NULL") }, class_name: 'Item'
  has_many :sold_items, -> { where("seller_id is not NULL && buyer_id is not NULL") }, class_name: 'Item'
  has_many :favorites, dependent: :destroy
  has_many :items, through: :favorites
  has_many :comments
  has_one :card

  # omniauth_user
  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_initialize
    user = sns.user || User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end
end
