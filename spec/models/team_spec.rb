require 'rails_helper'
RSpec.describe 'チーム管理機能', type: :model do
  describe 'バリデーションのテスト' do
    let!(:user) { FactoryBot.create(:user) }
    context 'チーム名が正しく入力されている場合' do
      it 'チームが作成される' do
        team = Team.new(name: 'サンプルチーム', reward: 'みんなで美味しいランチを食べにいこう', period: '2022-12-31', user_id:1)
        expect(team).to be_valid
      end
    end
    context 'チーム名が入力されていない場合' do
      it 'バリデーションにひっかかる' do
        team = Team.new(name: '', reward: 'みんなでランチを食べに行こう', period: '2022-12-31', user_id:1)
        expect(team).not_to be_valid
      end
    end
  end
end