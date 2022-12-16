require 'rails_helper'
RSpec.describe 'カテゴリー管理機能', type: :system do
  describe 'カテゴリー作成機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:team) { FactoryBot.create(:team, user: user) }
    let!(:assign) { FactoryBot.create(:assign, user: user, team: team) }
    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'hoge@hoge.com'
      fill_in 'パスワード', with: 'password'
      find('#rspec-notice').click
    end
    context 'タスク一覧から新しいタスクを作成した場合' do
      it 'カテゴリー名を登録し、作成したタスクが表示される' do
        find('#rspec-task-index').click
        find('#rspec-task-new').click
        click_on '新しいカテゴリを追加'
        fill_in 'カテゴリー', with: '資料作成'
        click_on '登録する'
        select '資料作成', from: 'task[category_id]'
        expect(page).to have_content '資料作成'
      end
    end
  end
  describe 'アクセス制限機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:team) { FactoryBot.create(:team, user: user) }
    let!(:assign) { FactoryBot.create(:assign, user: user, team: team) }
    let!(:guest) { FactoryBot.create(:guest) }
    let!(:team2) { FactoryBot.create(:team2, user: guest) }
    let!(:assign2) { FactoryBot.create(:assign2, user: guest, team: team2) }
    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'hoge@hoge.com'
      fill_in 'パスワード', with: 'password'
      find('#rspec-notice').click
    end
    context 'ユーザーが所属していないチームのカテゴリー作成画面に飛んだ場合' do
      it 'アクセス権限がありません、と表示される' do
        find('#rspec-task-index').click
        find('#rspec-task-new').click
        click_on '新しいカテゴリを追加'
        visit new_team_category_path(team_id:2)
        expect(page).to have_content 'アクセス権限がありません'
      end
    end
  end
end
