require 'rails_helper'
RSpec.describe 'カテゴリー管理機能', type: :model do
  describe 'バリデーションのテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:team) { FactoryBot.create(:team, user: user) }
    context 'カテゴリー名が正しく入力されている場合' do
      it 'タスクが作成される' do
        category = Category.new(name: '日用品', team_id: 1)
        expect(category).to be_valid
      end
    end
    context 'カテゴリー名が正しく入力されていない場合' do
      it 'バリデーションにひっかかる' do
        category = Category.new(name: '', team_id: 1)
        expect(category).not_to be_valid
      end
    end
  end
end