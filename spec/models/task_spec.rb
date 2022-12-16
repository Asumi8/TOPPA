require 'rails_helper'
RSpec.describe 'チーム管理機能', type: :model do
  describe 'バリデーションのテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:team) { FactoryBot.create(:team, user: user) }
    let!(:category) { FactoryBot.create(:category, team: team) }
    context 'カテゴリー名、タスク名、期限の情報が正しく入力されている場合' do
      it 'タスクが作成される' do
        task = Task.new(category_id: 1, name: 'プレゼン用の資料作成', expired_at: '2022-12-31', team_id: 1, user_id: 1)
        expect(task).to be_valid
      end
    end
    context 'カテゴリー名、タスク名、期限のいずれかの情報が正しく入力されていない場合' do
      it 'バリデーションにひっかかる' do
        task1 = Task.new(category_id: "", name: 'プレゼン用の資料作成', expired_at: '2022-12-31', team_id: 1, user_id: 1)
        task2 = Task.new(category_id: 1, name: '', expired_at: '2022-12-31', team_id: 1, user_id: 1)
        task3 = Task.new(category_id: 1, name: 'プレゼン用の資料作成', expired_at: '', team_id: 1, user_id: 1)
        expect(task1).not_to be_valid
        expect(task2).not_to be_valid
        expect(task3).not_to be_valid
      end
    end
  end
end