# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ゲストユーザー
@user = User.create!(
  name: 'ゲスト',
  email: 'guest@example.com',
  password: SecureRandom.urlsafe_base64
)

@user_team = Team.create!(
  user_id: @user.id,
  name: 'ゲストプロジェクト',
  reward: '一番頑張った人に◯◯を渡そう！',
  period: '2023-03-31'
)

@user_team_category1 = Category.create!(
  team_id: @user_team.id,
  name: '事前準備'
)

@user_team_category2 = Category.create!(
  team_id: @user_team.id,
  name: '情報収集'
)

@user_team_category3 = Category.create!(
  team_id: @user_team.id,
  name: '資料作成'
)

@task1 = Task.create!(
  team_id: @user_team.id,
  user_id: @user.id,
  category_id: @user_team_category1.id,
  name: '作業項目の洗い出し',
  expired_at: '2023-03-05'
)

@task2 = Task.create!(
  team_id: @user_team.id,
  user_id: @user.id,
  category_id: @user_team_category2.id,
  name: '必要な情報収集',
  expired_at: '2023-03-10'
)

@task3 = Task.create!(
  team_id: @user_team.id,
  user_id: @user.id,
  category_id: @user_team_category3.id,
  name: '発表用の資料の作成',
  expired_at: '2023-03-15'
)

# ゲスト管理者ユーザー
@admin_user = User.create!(
  name: 'ゲスト管理者',
  email: 'admin@example.com',
  password: SecureRandom.urlsafe_base64,
  admin: true
)

@admin_team = Team.create!(
  user_id: @admin_user.id,
  name: 'ゲスト管理者チーム',
  reward: '管理者チームで打ち上げしよう',
  period: '2023-03-31'
)

@admin_team_category1 = Category.create!(
  team_id: @admin_team.id,
  name: '買い出し'
)

@task1 = Task.create!(
  team_id: @admin_team.id,
  user_id: @admin_user.id,
  category_id: @admin_team_category1.id,
  name: '食材を買う',
  expired_at: '2023-03-05'
)
