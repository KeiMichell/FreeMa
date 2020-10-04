class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true
  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'
  belongs_to :buyer, class_name: 'User', optional: true, foreign_key: 'buyer_id'
  belongs_to :category
  belongs_to :brand, optional: true
  accepts_nested_attributes_for :brand, allow_destroy: true
  belongs_to_active_hash :condition
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :delivery_day
  belongs_to_active_hash :prefecture

  validates :images, presence: true
  validates :name, presence: true, length: { maximum: 40 }
  validates :detail, presence: true, length: { maximum: 1000 }
  validates :price, presence: true, inclusion: { in: (300..9_999_999) }
  validates :condition_id, presence: true
  validates :prefecture_id, presence: true
  validates :delivery_fee_id, presence: true
  validates :delivery_day_id, presence: true
  validates :category_id, presence: true
end
