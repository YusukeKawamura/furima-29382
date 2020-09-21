FactoryBot.define do
  factory :item do
    name { 'テスト商品' }
    description { '商品説明が入力されている' }
    category_id  { 2 }
    condition_id { 2 }
    ship_method_id { 2 }
    prefecture_id { 2 }
    ship_date_id { 2 }
    price { 1000 }
    association :user

    after(:build) do |picture|
      picture.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
