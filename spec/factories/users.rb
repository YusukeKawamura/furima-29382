FactoryBot.define do
  factory :user do
    nickname { Faker::Creature::Animal.name }
    email { Faker::Internet.free_email }
    password = 'a' + Faker::Internet.password(min_length: 6, max_length: 126) + '1'
    password { password }
    password_confirmation { password }
    gimei = Gimei.name
    family_name { gimei.last.kanji }
    first_name { gimei.first.kanji }
    family_name_kana { gimei.last.katakana }
    first_name_kana { gimei.first.katakana }
    birth_day { Faker::Date.between(from: '1930-01-01', to: '2015-12-31') }
  end
end
