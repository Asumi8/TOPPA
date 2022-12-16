require 'rails_helper'
RSpec.describe 'コメント管理機能', type: :model do
  describe 'バリデーションのテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:team) { FactoryBot.create(:team, user: user) }
    let!(:category) { FactoryBot.create(:category, team: team) }
    let!(:task) { FactoryBot.create(:task, user: user, team: team) }
    context 'カテゴリー名が正しく入力されている場合' do
      it 'タスクが作成される' do
        comment = Comment.new(content: '◯◯さんお願いします！', task_id: 1, user_id: 1)
        expect(comment).to be_valid
      end
    end
    context 'カテゴリー名が正しく入力されていない場合' do
      it 'バリデーションにひっかかる' do
        comment = Comment.new(content: '', task_id: 1, user_id: 1)
        expect(comment).not_to be_valid
      end
    end
  end
end