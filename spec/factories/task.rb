FactoryBot.define do
  factory :task do
    id { 1 }
    category_id { '1' }
    name { 'プレゼン用の資料' }
    expired_at { '2022-12-31' }
    status { 'false' }
    user_id { 1 }
    team_id { 1 }
    created_at { '2022-12-01' }
  end
  factory :task2, class: Task do
    id { 2 }
    category_id { '1' }
    name { '社内発表用の資料' }
    expired_at { '2022-12-15' }
    status { 'true' }
    user_id { 1 }
    team_id { 1 }
    created_at { '2022-12-02' }
  end
end