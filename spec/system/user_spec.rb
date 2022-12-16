require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  describe 'ユーザー登録機能' do
    context 'ユーザーが新規登録をした場合' do
      it 'アカウント登録ができ、チーム一覧に遷移できる' do
        visit new_user_registration_path
        fill_in '名前', with: 'name_1'
        fill_in 'メールアドレス', with: 'mail@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in '確認用パスワード', with: 'password'
        find('#rspec-notice').click
        expect(page).to have_content 'アカウント登録が完了しました'
      end
    end
  end
  describe 'セッション機能' do
    context 'ユーザーがログインした場合' do
      it 'ログインができる' do
        FactoryBot.create(:user)
        visit new_user_session_path
        fill_in 'メールアドレス', with: 'hoge@hoge.com'
        fill_in 'パスワード', with: 'password'
        find('#rspec-notice').click
        expect(page).to have_content 'ログインしました。'
      end
    end
    context 'ゲストユーザーがログインした場合' do
      it 'ログインができる' do
        FactoryBot.create(:guest)
        visit root_path
        click_on 'ゲストログイン'
        expect(page).to have_content 'ゲストユーザーとしてログインしました。'
      end
    end
    context '管理者ゲストユーザーがログインした場合' do
      it 'ログインができる' do
        FactoryBot.create(:admin)
        visit root_path
        click_on 'ゲスト管理者ログイン'
        expect(page).to have_content 'ゲスト管理者ユーザーとしてログインしました。'
      end
    end
    context 'ユーザーがログインせずにチーム一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit root_path
        visit teams_path
        expect(page).to have_content 'ログインもしくはアカウント登録してください。'
      end
    end
  end
  describe '管理者画面機能' do
    context '管理者ゲストユーザーがログインした場合' do
      it '管理画面に遷移できる' do
        FactoryBot.create(:admin)
        visit root_path
        click_on 'ゲスト管理者ログイン'
        click_on '管理者画面'
        expect(page).to have_content 'Toppa Admin'
      end
    end
  end
end