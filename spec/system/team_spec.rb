require 'rails_helper'
RSpec.describe 'チーム管理機能', type: :system do
  describe 'CRUD機能' do
    let!(:user) { FactoryBot.create(:user) }
    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'hoge@hoge.com'
      fill_in 'パスワード', with: 'password'
      find('#rspec-notice').click
    end
    context 'チーム一覧からチームを新しく作成した場合' do
      it '作成したチームが表示される' do
        find('#rspec-team-new').click
        fill_in 'チーム名', with: 'hogehogeチーム'
        fill_in 'チームのご褒美/目標', with: 'みんなで美味しいご飯を食べに行こう'
        fill_in '達成期限', with: '2023-01-30'
        click_on '登録する'
        expect(page).to have_content 'チームを作成しました！'
      end
    end
    context 'チーム一覧から任意のチームを選択した場合' do
      it 'そのチームの詳細が表示される' do
        find('#rspec-team-new').click
        fill_in 'チーム名', with: 'hogehogeチーム'
        fill_in 'チームのご褒美/目標', with: 'みんなで美味しいご飯を食べに行こう'
        fill_in '達成期限', with: '2023-01-30'
        click_on '登録する'
        click_on 'チームの詳細'
        expect(page).to have_content 'My Team'
      end
    end
    context '任意のチームを編集した場合' do
      it '変更した内容が反映されている' do
        find('#rspec-team-new').click
        fill_in 'チーム名', with: 'hogehogeチーム'
        fill_in 'チームのご褒美/目標', with: 'みんなで美味しいご飯を食べに行こう'
        fill_in '達成期限', with: '2023-01-30'
        click_on '登録する'
        click_on 'チームの詳細'
        execute_script('window.scrollBy(0,10000)')
        sleep(1)
        execute_script('window.scrollBy(0,10000)')
        sleep(1)
        click_on 'チームを編集'
        fill_in 'チーム名', with: 'fugafugaチーム'
        click_on '更新する'
        expect(page).to have_content 'チームを編集しました！'
      end
    end
    context '任意のチームを削除した場合' do
      it 'そのチームがチーム一覧から削除されるる' do
        find('#rspec-team-new').click
        fill_in 'チーム名', with: 'hogehogeチーム'
        fill_in 'チームのご褒美/目標', with: 'みんなで美味しいご飯を食べに行こう'
        fill_in '達成期限', with: '2023-01-30'
        click_on '登録する'
        click_on 'チームの詳細'
        execute_script('window.scrollBy(0,10000)')
        sleep(1)
        execute_script('window.scrollBy(0,10000)')
        sleep(1)
        find('#rspec-team-destroy').click
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'チームを削除しました。'
      end
    end
  end
  describe 'アクセス制限' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:guest) { FactoryBot.create(:guest) }
    let!(:team) { FactoryBot.create(:team, user: user) }
    let!(:team2) { FactoryBot.create(:team2, user: guest) }
    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'hoge@hoge.com'
      fill_in 'パスワード', with: 'password'
      find('#rspec-notice').click
    end
    context 'ユーザーが所属していないチームの詳細画面に飛んだ場合' do
      it 'アクセス権限がありません、と表示される' do
        find('#rspec-team-new').click
        fill_in 'チーム名', with: 'hogehogeチーム'
        fill_in 'チームのご褒美/目標', with: 'みんなで美味しいご飯を食べに行こう'
        fill_in '達成期限', with: '2023-01-30'
        click_on '登録する'
        click_on 'チームの詳細'
        visit team_path(2)
        expect(page).to have_content 'アクセス権限がありません'
      end
    end
  end
end