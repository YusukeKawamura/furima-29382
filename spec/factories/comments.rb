FactoryBot.define do
  factory :comment do
    content { 'テストコメント' }

    association :user
    association :item
  end
end
