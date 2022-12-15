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
        click_on 'spec_notice'
        sleep(2)
        expect(page).to have_content 'アカウント登録が完了しました'
      end
    end
    context 'ユーザーがログインせずにチーム一覧に飛ぼうとした場合' do
      it 'ログイン画面に遷移する' do
      end
    end
  end
  describe 'セッション機能' do
    context 'ユーザーがログインした場合' do
      it 'ログインができる' do
      end
    end
    context 'ゲストユーザーがログインした場合' do
      it 'ログインができる' do
      end
    end
    context '管理者ゲストユーザーがログインした場合' do
      it 'ログインができる' do
      end
    end
    context 'ユーザーがログインせずにチーム一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移する' do
      end
    end
  end
  describe '管理者画面機能' do
    context '管理者ゲストユーザーがログインした場合' do
      it '管理画面に遷移できる' do
      end
    end
    context '一般ユーザーがログインした場合' do
      it '管理画面に遷移できない' do
      end
    end
  end
end