FactoryBot.define do
  factory :team do
    id { 1 }
    name { "hogehogeチーム" }
    reward { "みんなで美味しいご飯を食べに行こう" }
    period { "2022-01-30" }
  end
  factory :team2, class: Team do
    id { 2 }
    name { "fugafugaチーム" }
    reward { "1番がんばった人に◯◯をプレゼント" }
    period { "2022-02-30" }
  end
end