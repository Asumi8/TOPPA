require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  # describe 'CRUD機能' do
  #   let!(:user) { FactoryBot.create(:user) }
  #   let!(:team) { FactoryBot.create(:team, user: user) }
  #   before do
  #     visit new_user_session_path
  #     fill_in 'メールアドレス', with: 'hoge@hoge.com'
  #     fill_in 'パスワード', with: 'password'
  #     find('#rspec-notice').click
  #     find('#rspec-team-new').click
  #     fill_in 'チーム名', with: 'hogehogeチーム'
  #     click_on '登録する'
  #   end
  #   context 'タスク一覧から新しいタスクを作成した場合' do
  #     it 'カテゴリー名を登録し、作成したタスクが表示される' do
  #       find('#rspec-task-index').click
  #       find('#rspec-task-new').click
  #       click_on '新しいカテゴリを追加'
  #       fill_in 'カテゴリー', with: '資料作成'
  #       click_on '登録する'
  #       select '資料作成', from: 'task[category_id]'
  #       fill_in 'task[name]', with: 'プレゼン資料を作成'
  #       fill_in 'task[expired_at]', with: '2023-01-30'
  #       click_on '登録する'
  #       expect(page).to have_content 'タスクを作成しました！'
  #     end
  #   end
  #   context '新しいタスクを作成する際、必須項目を空のまま登録しようとした場合' do
  #     it 'エラーがあります、と表示される' do
  #       find('#rspec-task-index').click
  #       find('#rspec-task-new').click
  #       fill_in 'task[name]', with: ''
  #       fill_in 'task[expired_at]', with: ''
  #       click_on '登録する'
  #       expect(page).to have_content 'エラーがあります。'
  #     end
  #   end
  #   context 'タスク一覧から任意のタスクを選択した場合' do
  #     it 'そのタスクの詳細が表示される' do
  #       find('#rspec-task-index').click
  #       find('#rspec-task-new').click
  #       click_on '新しいカテゴリを追加'
  #       fill_in 'カテゴリー', with: '資料作成'
  #       click_on '登録する'
  #       select '資料作成', from: 'task[category_id]'
  #       fill_in 'task[name]', with: 'プレゼン資料を作成'
  #       fill_in 'task[expired_at]', with: '2023-01-30'
  #       click_on '登録する'
  #       click_on '詳細'
  #       expect(page).to have_content 'Task Details'
  #     end
  #   end
  #   context '任意のタスクを編集した場合' do
  #     it '変更した内容が反映されている' do
  #       find('#rspec-task-index').click
  #       find('#rspec-task-new').click
  #       click_on '新しいカテゴリを追加'
  #       fill_in 'カテゴリー', with: '資料作成'
  #       click_on '登録する'
  #       select '資料作成', from: 'task[category_id]'
  #       fill_in 'task[name]', with: 'プレゼン資料を作成'
  #       fill_in 'task[expired_at]', with: '2023-01-30'
  #       click_on '登録する'
  #       click_on '編集'
  #       fill_in 'task[name]', with: '●●社へのプレゼン資料を作成'
  #       click_on '更新する'
  #       expect(page).to have_content 'タスクを編集しました！'
  #     end
  #   end
  #   context '任意のタスクを削除した場合' do
  #     it 'そのタスクがタスク一覧から削除される' do
  #       find('#rspec-task-index').click
  #       find('#rspec-task-new').click
  #       click_on '新しいカテゴリを追加'
  #       fill_in 'カテゴリー', with: '資料作成'
  #       click_on '登録する'
  #       select '資料作成', from: 'task[category_id]'
  #       fill_in 'task[name]', with: 'プレゼン資料を作成'
  #       fill_in 'task[expired_at]', with: '2023-01-30'
  #       click_on '登録する'
  #       click_on '削除'
  #       page.driver.browser.switch_to.alert.accept
  #       expect(page).to have_content 'タスクを削除しました。'
  #     end
  #   end
  # end
  describe 'ソート機能' do
    let!(:user) { FactoryBot.create(:user) }
    #let!(:guest) { FactoryBot.create(:guest) }
    let!(:team) { FactoryBot.create(:team, user: user) }
    #let!(:team2) { FactoryBot.create(:team2, user: guest) }
    let!(:assign) { FactoryBot.create(:assign, user: user, team: team) }
    #let!(:assign2) { FactoryBot.create(:assign2, user: guest, team: team) }
    let!(:category) { FactoryBot.create(:category, team: team) }
    let!(:task) { FactoryBot.create(:task, user: user, team: team) }
    let!(:task2) { FactoryBot.create(:task2, user: user, team: team) }
    #let!(:task2) { FactoryBot.create(:task2, user: guest, team: team) }
    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'hoge@hoge.com'
      fill_in 'パスワード', with: 'password'
      find('#rspec-notice').click
    end
    context 'タスク一覧画面で「未実行のみ絞り込む」を押した場合' do
      it '未実行（status:false）のタスクのみが表示される' do
        find('#rspec-task-index').click
        click_on '未実行のみ絞り込む'
        expect(page).not_to have_content '社内発表用の資料'
      end
    end
    context 'タスク一覧画面で「実行状況で並び替え」を押した場合' do
      it '「プレゼン用の資料」が一番上部に表示される' do
        find('#rspec-task-index').click
        click_on '実行状況で並び替え'
        within ".container" do
          sleep(1)
          expired_days = all(".rspec").map(&:text)
          sleep(1)
          expect(expired_days).to eq ["プレゼン用の資料", "社内発表用の資料"]
        end
      end
    end
    context 'タスク一覧画面で「期限で並び替え」を押した場合' do
      it '「社内発表用の資料」が一番上部に表示される' do
        find('#rspec-task-index').click
        click_on '期限で並び替え'
        within ".container" do
          sleep(1)
          expired_days = all(".rspec").map(&:text)
          sleep(1)
          expect(expired_days).to eq ["社内発表用の資料", "プレゼン用の資料"]
        end
      end
    end
    context 'タスク一覧画面で「作成日で並び替え」を押した場合' do
      it '「社内発表用の資料」が一番上部に表示される' do
        find('#rspec-task-index').click
        click_on '作成日で並び替え'
        within ".container" do
          sleep(1)
          expired_days = all(".rspec").map(&:text)
          sleep(1)
          expect(expired_days).to eq ["プレゼン用の資料", "社内発表用の資料"]
        end
      end
    end
  end
  describe 'アクセス制限機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:guest) { FactoryBot.create(:guest) }
    let!(:team) { FactoryBot.create(:team, user: user) }
    let!(:team2) { FactoryBot.create(:team2, user: guest) }
    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'hoge@hoge.com'
      fill_in 'パスワード', with: 'password'
      find('#rspec-notice').click
      find('#rspec-team-new').click
      fill_in 'チーム名', with: 'hogehogeチーム'
      click_on '登録する'
    end
    context 'ユーザーが所属していないチームの持つタスク一覧画面に飛んだ場合' do
      it 'アクセス権限がありません、と表示される' do
        find('#rspec-task-index').click
        visit team_tasks_path(team_id:2)
        sleep(1)
        expect(page).to have_content 'アクセス権限がありません'
      end
    end
  end
end