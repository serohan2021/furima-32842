FactoryBot.define do
  factory :order_destination do
    post_code      { '123-4567' }
    region_id      { Faker::Number.between(from: 2, to: 48) }
    city           { Gimei.address.city.to_s }
    address        { Gimei.address.town.to_s + '1-22-3' }
    building_name  { 'フェニックス南阿佐ヶ谷' }
    phone_number   { Faker::Number.number(digits: 11) }
    token          { 'tok_abcdefghijk00000000000000000' }
  end
end
