require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'バリデーションのテスト' do
    context '名前、メールアドレス、パスワードの情報が正しく入力されている場合' do
      it 'アカウント登録が完了する' do
        user = User.new(name: 'user', email: 'user@example.com', password: 'password', password_confirmation: 'password')
        expect(user).to be_valid
      end
    end
    context '名前、メールアドレス、パスワードのいずれかの情報が入力されない場合' do
      it 'バリデーションにひっかかる' do
        user1 = User.new(name: '', email: 'user@example.com', password: 'password', password_confirmation: 'password')
        user2 = User.new(name: 'user2', email: '', password: 'password', password_confirmation: 'password')
        user3 = User.new(name: 'user3', email: 'user3@example.com', password: '', password_confirmation: 'password')
        user4 = User.new(name: 'user4', email: 'user4@example.com', password: 'password', password_confirmation: '')
        expect(user1).not_to be_valid
        expect(user2).not_to be_valid
        expect(user3).not_to be_valid
        expect(user4).not_to be_valid
      end
    end
  end
end

