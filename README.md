# テーブル設計

## users テーブル

| Column             | Type   | Options     |
|--------------------|--------|-------------|
| nickname           | string | null: false |
| email              | string | null: false |
| password           | string | null: false |
| encrypted_password | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birth_year         | string | null: false |
| birth_month        | string | null: false |
| birth_day          | string | null: false |

### Association
- has_many :items
- has_many :orders

## items テーブル

| Column        | Type       | Options                        |
|---------------|------------|--------------------------------|
| image         | string     | null: false                    |
| name          | string     | null: false                    |
| description   | text       | null: false                    |
| category      | string     | null: false                    |
| condition     | string     | null: false                    |
| postage_type  | string     | null: false                    |
| shipping_area | string     | null: false                    |
| shipping_days | string     | null: false                    |
| price         | integer    | null: false                    |
| user_id       | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :order

## orders テーブル

| Column         | Type       | Options                        |
|----------------|------------|--------------------------------|
| user_id        | references | null: false, foreign_key: true |
| item_id        | references | null: false, foreign_key: true |
| destination_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- belongs_to :destination

## destinations テーブル

| Column         | Type        | Options                        |
|----------------|-------------|--------------------------------|
| post_code      | string      | null: false                    |
| prefecture     | string      | null: false                    |
| city           | string      | null: false                    |
| address        | string      | null: false                    |
| building_name  | string      |                                |
| phone_number   | string      | null: false, foreign_key: true |

### Association

- has_many :orders