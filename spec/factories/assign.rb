FactoryBot.define do
  factory :assign do
    id { 1 }
    user_id { 1 }
    team_id { 1 }
  end
  factory :assign2, class: Assign do
    id { 2 }
    user_id { 2 }
    team_id { 1 }
  end
end