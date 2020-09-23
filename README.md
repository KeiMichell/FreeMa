# DB設計

## Usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false, unique: true|
|email|string|null: false, unique: true|
|encypted_password|string|null: false|
|last_name|string|null: false|
|first_name|string|null: false|
|last_name_kana|string|null: false|
|first_name_kana|string|null: false|
|profile|text||
|image|string||
|birthday|date|null: false|
### Association
- has_many :items
- has_one: address
- has_one: card

## Addressesテーブル
|Column|Type|Options|
|------|----|-------|
|last_name|string|null: false|
|first_name|string|null: false|
|last_name_kana|string|null: false|
|first_name_kana|string|null: false|
|postcode|string|null: false|
|prefecture_id|integer|null: false|
|city|string|null: false|
|block|string|null: false|
|buildung|string||
|phone_number|string||
|user|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to_active_hash :prefecture

## Cardsテーブル
|Column|Type|Options|
|------|----|-------|
|card_id|string|null: false|
|customer_id|string|null: false|
|user|references|null: false, foreign_key: true|
### Association
- belongs_to :user

## Itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|detail|text|null: false|
|price|integer|null: false|
|condition_id|integer|null: false|
|delivery_fee_id|integer|null: false|
|prefecture_id|integer|null: false|
|delivery_day_id|integer|null: false|
|brand|references|foreign_key: true|
|category|references|null: false, foreign_key: true|
|seller|references|null: false, foreign_key: true|
|buyer|references|null: false, foreign_key: true|
### Association
- has_many :images
- belongs_to :user
- belongs_to :category
- belongs_to :brand
- belongs_to_active_hash :condition
- belongs_to_active_hash :delivery_fee
- belongs_to_active_hash :delivery_day
- belongs_to_active_hash :prefecture

## Imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item|references|null: false, foreign_key: true|
### Association
- belongs_to :item

## Categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string||
### Association
- has_many :items
- has_ancestry

## Brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many :items
