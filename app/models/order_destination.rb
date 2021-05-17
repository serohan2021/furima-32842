class OrderDestination
  include ActiveModel::Model
  attr_accessor :post_code, :region_id, :city, :address, :building_name, :phone_number, :user_id, :item_id

  # ここにバリデーションの処理を書く
  with_options presence: true do
    validates :post_code
    validates :region_id, numericality: { only_integer: true, other_than: 1 }
    validates :city
    validates :address
    validates :phone_number, numericality: { only_integer: true }, length: { minimum: 9 }
    validates :user_id
    validates :item_id
  end

  def save
    # 各テーブルにデータを保存する処理を書く
    order = Order.create(user_id: user_id, item_id: item_id)
    Destination.create(post_code: post_code, region_id: region_id, city: city, address: address,
                       building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end
