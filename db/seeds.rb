@guest = User.create!(
  name: 'ゲスト',
  email: 'guest@example.com',
  password: SecureRandom.urlsafe_base64
)


@guest_team = Team.create!(
  user_id: @guest.id,
  name: 'ゲストプロジェクト',
  reward: '一番頑張った人に◯◯を渡そう！',
  period: '2023-03-31'
)

Assign.create!(
  user_id: @guest.id,
  team_id: @guest_team.id
)

@guest_team_category1 = Category.create!(
  team_id: @guest_team.id,
  name: '事前準備'
)

@guest_team_category2 = Category.create!(
  team_id: @guest_team.id,
  name: '情報収集'
)

@guest_team_category3 = Category.create!(
  team_id: @guest_team.id,
  name: '資料作成'
)

@guest_task1 = Task.create!(
  team_id: @guest_team.id,
  user_id: @guest.id,
  category_id: @guest_team_category1.id,
  name: '作業項目の洗い出し',
  expired_at: '2023-03-05'
)

@guest_task2 = Task.create!(
  team_id: @guest_team.id,
  user_id: @guest.id,
  category_id: @guest_team_category2.id,
  name: '必要な情報収集',
  expired_at: '2023-03-10'
)

@guest_task3 = Task.create!(
  team_id: @guest_team.id,
  user_id: @guest.id,
  category_id: @guest_team_category3.id,
  name: '発表用の資料の作成',
  expired_at: '2023-03-15'
)


@user_1 = User.create!(
  name: 'hoge',
  email: 'hoge@hoge.com',
  password: SecureRandom.urlsafe_base64
)

@user_2 = User.create!(
  name: 'fuga',
  email: 'fuga@fuga.com',
  password: SecureRandom.urlsafe_base64
)

@user_3 = User.create!(
  name: 'piyo',
  email: 'piyo@piyo.com',
  password: SecureRandom.urlsafe_base64
)

@user_team1 = Team.create!(
  user_id: @guest.id,
  name: 'ゲストファミリー/消耗品購入',
  reward: '一番は次回の外食を決めれる',
  period: '2023-03-31'
)

Assign.create!(
  user_id: @guest.id,
  team_id: @user_team1.id
)
Assign.create!(
  user_id: @user_1.id,
  team_id: @user_team1.id
)
Assign.create!(
  user_id: @user_2.id,
  team_id: @user_team1.id
)
Assign.create!(
  user_id: @user_3.id,
  team_id: @user_team1.id
)

@user_team_category1 = Category.create!(
  team_id: @user_team1.id,
  name: '洗剤系'
)

@user_team_category2 = Category.create!(
  team_id: @user_team1.id,
  name: '化粧品関連'
)

@user_team_category3 = Category.create!(
  team_id: @user_team1.id,
  name: 'その他'
)

@user_task1 = Task.create!(
  team_id: @user_team1.id,
  user_id: @user_1.id,
  category_id: @user_team_category1.id,
  name: '洗濯洗剤',
  repeat: true,
  expired_at: '2023-03-05'
)

@user_task2 = Task.create!(
  team_id: @user_team1.id,
  user_id: @user_2.id,
  category_id: @user_team_category1.id,
  name: '柔軟剤',
  repeat: true,
  expired_at: '2023-03-10'
)

@user_task3 = Task.create!(
  team_id: @user_team1.id,
  user_id: @user_3.id,
  category_id: @user_team_category1.id,
  name: '食器用洗剤',
  repeat: true,
  expired_at: '2023-03-15'
)

@user_task4 = Task.create!(
  team_id: @user_team1.id,
  user_id: @user_3.id,
  category_id: @user_team_category2.id,
  name: '化粧水',
  repeat: true,
  expired_at: '2023-03-05'
)

@user_task5 = Task.create!(
  team_id: @user_team1.id,
  user_id: @user_3.id,
  category_id: @user_team_category2.id,
  name: '乳液',
  repeat: true,
  expired_at: '2023-03-05'
)

@user_task6 = Task.create!(
  team_id: @user_team1.id,
  user_id: @user_3.id,
  category_id: @user_team_category2.id,
  name: 'コットン',
  repeat: true,
  expired_at: '2023-03-10'
)

@user_task7 = Task.create!(
  team_id: @user_team1.id,
  user_id: @user_2.id,
  category_id: @user_team_category3.id,
  name: 'ボックスティッシュ',
  repeat: true,
  expired_at: '2023-02-15'
)

@user_task8 = Task.create!(
  team_id: @user_team1.id,
  user_id: @user_1.id,
  category_id: @user_team_category3.id,
  name: 'トイレットペーパー',
  repeat: true,
  expired_at: '2023-02-20'
)


@user_4 = User.create!(
  name: 'foo',
  email: 'foo@foo.com',
  password: SecureRandom.urlsafe_base64
)

@user_5 = User.create!(
  name: 'bar',
  email: 'bar@bar.com',
  password: SecureRandom.urlsafe_base64
)

@user_team2 = Team.create!(
  user_id: @user_4.id,
  name: '5人で沖縄旅行！',
  reward: '準備頑張った人にご飯おごる',
  period: '2023-03-31'
)


Assign.create!(
  user_id: @guest.id,
  team_id: @user_team2.id
)
Assign.create!(
  user_id: @user_1.id,
  team_id: @user_team2.id
)
Assign.create!(
  user_id: @user_2.id,
  team_id: @user_team2.id
)
Assign.create!(
  user_id: @user_3.id,
  team_id: @user_team2.id
)
Assign.create!(
  user_id: @user_4.id,
  team_id: @user_team2.id
)

@user_team_category4 = Category.create!(
  team_id: @user_team2.id,
  name: '予約'
)

@user_team_category5 = Category.create!(
  team_id: @user_team2.id,
  name: '計画'
)


@user_task9 = Task.create!(
  team_id: @user_team2.id,
  user_id: @user_1.id,
  category_id: @user_team_category4.id,
  status: true,
  name: 'レンタカーの予約',
  expired_at: '2023-03-05'
)

@user_task10 = Task.create!(
  team_id: @user_team2.id,
  user_id: @user_2.id,
  category_id: @user_team_category4.id,
  name: '1日目の宿予約',
  expired_at: '2023-03-10'
)

@user_task11 = Task.create!(
  team_id: @user_team2.id,
  user_id: @user_3.id,
  category_id: @user_team_category5.id,
  name: '1日目プラン立てる',
  expired_at: '2023-03-15'
)

Comment.create!(
  task_id: @user_task9.id,
  user_id: @user_4.id,
  content: "ありがとう！助かる！"
)

Comment.create!(
  task_id: @user_task9.id,
  user_id: @user_5.id,
  content: "さっそくありがと〜〜"
)


@admin_user = User.create!(
  name: 'ゲスト管理者',
  email: 'admin@example.com',
  password: SecureRandom.urlsafe_base64,
  admin: true
)

@admin_team = Team.create!(
  user_id: @admin_user.id,
  name: 'ゲスト管理者チーム',
  reward: '管理者チームでプチ打ち上げしよう',
  period: '2023-03-31'
)

Assign.create!(
  user_id: @admin_user.id,
  team_id: @admin_team.id
)

Assign.create!(
  user_id: @user_3.id,
  team_id: @admin_team.id
)

Assign.create!(
  user_id: @user_5.id,
  team_id: @admin_team.id
)
@admin_team_category1 = Category.create!(
  team_id: @admin_team.id,
  name: '買い出し'
)

@admin_team_category2 = Category.create!(
  team_id: @admin_team.id,
  name: '予約'
)

@admin_team_category3 = Category.create!(
  team_id: @admin_team.id,
  name: '声かけ'
)

@user_task12 = Task.create!(
  team_id: @admin_team.id,
  user_id: @admin_user.id,
  category_id: @admin_team_category1.id,
  name: '飲み物買う',
  expired_at: '2023-03-05'
)
@user_task13 = Task.create!(
  team_id: @admin_team.id,
  user_id: @admin_user.id,
  category_id: @admin_team_category1.id,
  name: '大人数用のご飯買う',
  expired_at: '2023-03-05'
)
@user_task14 = Task.create!(
  team_id: @admin_team.id,
  user_id: @admin_user.id,
  category_id: @admin_team_category2.id,
  name: '会議室を予約する',
  status: true,
  expired_at: '2023-03-02'
)
@user_task15 = Task.create!(
  team_id: @admin_team.id,
  user_id: @admin_user.id,
  status: true,
  category_id: @admin_team_category3.id,
  name: 'メンバーに告知する',
  expired_at: '2023-03-01'
)
Comment.create!(
  task_id: @user_task14.id,
  user_id: @user_3.id,
  content: "ありがとうございます！！"
)

Comment.create!(
  task_id: @user_task14.id,
  user_id: @admin_user.id,
  content: "いえいえです！！"
)

Comment.create!(
  task_id: @user_task15.id,
  user_id: @user_5.id,
  content: "ありがとうございました！"
)

@user_team3 = Team.create!(
  user_id: @guest.id,
  name: 'ゲスト企画',
  reward: '',
  period: '2023-03-31'
)

Assign.create!(
  user_id: @guest.id,
  team_id: @user_team3.id
)