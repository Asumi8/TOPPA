FactoryBot.define do
  factory :task do
    id { 1 }
    category_id { '1' }
    name { '資料作成' }
    expired_at { '2022-12-31' }
    user_id { 1 }
    team_id { 1 }
  end
end