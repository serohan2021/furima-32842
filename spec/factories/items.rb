FactoryBot.define do
  factory :item do
    name                  { 'サンプル試験１:' + Faker::JapaneseMedia::OnePiece.akuma_no_mi }
    description           { '食べると泳げなくなります。' + Faker::Lorem.sentence }
    price                 { Faker::Number.between(from: 300, to: 9_999_999) }
    category_id           { Faker::Number.between(from: 2, to: 11) }
    condition_id          { Faker::Number.between(from: 2, to: 7) }
    postage_type_id       { Faker::Number.between(from: 2, to: 3) }
    region_id             { Faker::Number.between(from: 2, to: 48) }
    shipping_day_id       { Faker::Number.between(from: 2, to: 4) }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
