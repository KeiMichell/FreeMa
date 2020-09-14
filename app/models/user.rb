class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validation_definition
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_NAME_REGEX = /\A[ぁ-んァ-ン一-龥]/
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

end
