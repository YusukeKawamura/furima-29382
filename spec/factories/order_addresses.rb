FactoryBot.define do
  factory :order_address do
    token { 'dummytoken' }
    postcode { '123-4567' }
    prefecture_id { '2' }
    municipality { '南市' }
    street { '東123' }
    apartment { 'マンション西999' }
    tel { '01234567890' }
  end
end
