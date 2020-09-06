# DB設計

## Usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false, unique: true|
|email|string|null: false, unique: true|
|password|string|null: false|
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
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user

## Cardsテーブル
|Column|Type|Options|
|------|----|-------|
|card_id|string|null: false|
|customer_id|string|null: false|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user

## Itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|detail|text|null: false|
|price|integer|null: false|
|size|string|null: false|
|states|string|null: false|
|delivery_fee|string|null: false|
|prefecture_id|integer|null: false|
|delivery_day|string|null: false|
|brand_id|integer|foreign_key: true|
|category_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|
### Association
- has_many :images
- belongs_to :user
- belongs_to :category
- belongs_to :brand

## Imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :item

## Categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|parent_id|integer|null: false|
### Association
- has_many :items

## Brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string||
### Association
- has_many :items
