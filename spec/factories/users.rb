FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { 'qwerty123' }
  end
end
