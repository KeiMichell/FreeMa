class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validation_definition
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[\d])\w{7,32}\z/
  VALID_NAME_REGEX = /\A[ぁ-んァ-ン一-龥]/
  VALID_KANA_REGEX = /\A[ぁ-んー－]+\z/

  # Registrations_validation
  validates :nickname, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true, 
            format: { with: VALID_EMAIL_REGEX, message: "フォーマットが不適切です" }
  validates :encrypted_password, presence: true, length: { minimum: 7, maximum: 32},
            format: { with: VALID_PASSWORD_REGEX, message: "半角英数字7~32文字、英大文字・小文字・数字それぞれ１文字以上含む必要があります" }
  validates :last_name, presence: true, length: { maximum: 30 },
            format: { with: VALID_NAME_REGEX, message: "全角ひらがな、全角カタカナ、漢字で入力してください" }
  validates :first_name, presence: true,  length: { maximum: 30 },
            format: { with: VALID_NAME_REGEX, message: "全角ひらがな、全角カタカナ、漢字で入力してください" }
  validates :last_name_kana, presence: true, length: { maximum: 30 },
            format: { with: VALID_KANA_REGEX, message: "全角ひらがなで入力してください" }
  validates :first_name_kana, presence: true, length: { maximum: 30 },
            format: { with: VALID_KANA_REGEX, message: "全角ひらがなで入力してください" }
  validates :birthday, presence: true

end
