FactoryBot.define do
  factory :user do
    id { 1 }
    name { "hoge" }
    email { "hoge@hoge.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { false }
  end
  factory :guest, class: User do
    name { "guest" }
    email { "guest@example.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { false }
  end
  factory :admin, class: User do
    name { "admin" }
    email { "admin@example.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { true }
  end
end