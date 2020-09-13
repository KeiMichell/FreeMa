class Address < ApplicationRecord
  # Validation_definition
  VALID_NAME_REGEX = /\A[ぁ-んァ-ン一-龥]/
  VALID_KANA_REGEX = /\A[ぁ-んー－]+\z/

  # Registrations_validation
  validates :last_name, presence: true, length: { maximum: 30 },
            format: { with: VALID_NAME_REGEX, message: "全角ひらがな、全角カタカナ、漢字で入力してください" }
  validates :first_name, presence: true,  length: { maximum: 30 },
            format: { with: VALID_NAME_REGEX, message: "全角ひらがな、全角カタカナ、漢字で入力してください" }
  validates :last_name_kana, presence: true, length: { maximum: 30 },
            format: { with: VALID_KANA_REGEX, message: "全角ひらがなで入力してください" }
  validates :first_name_kana, presence: true, length: { maximum: 30 },
            format: { with: VALID_KANA_REGEX, message: "全角ひらがなで入力してください" }
  validates :postcode, presence: true
  validates :prefecture_id, presence: true
  validates :city, presence: true
  validates :block, presence: true

  # Association
  belongs_to :user, optional: true
  
end
