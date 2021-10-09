require 'rails_helper'

  RSpec.describe User,type: :model do
    describe '#total_score' do
      # FactoryBot/user.rb
      let(:user1) { create(:user) }

      context 'user_scoresテーブルにデータがある場合' do
        before do
          # FactoryBot/user_score.rb
          # scoreはデフォルトの1が設定された状態でデータが作成されるが、create(:user_score, score: 4)とすることで、score値を上書きをしてデータが作成できる
          create(:user_score, user: user1, score:4)
          create(:user_score, user: user1, score:5)
          create(:user_score, user: user1, score:6)
        end
        
        it 'スコアの合計値を取得できる' do
          expect(user1.total_score).to eq 15
        end
      end

      context 'user_scoresテーブルにデータがない場合' do
        it 'スコアの合計は0である' do
          expect(user1.total_score).to eq 0
        end
      end

    end
  end

# テストコードはほぼ必ずと言ってよいほど場合分けが必要

# 今回の場合分け
# user_scoresテーブルにデータがある場合
# user_scoresテーブルにデータがない場合

# まとめると
# 1.user_scoresテーブルにデータがある場合は、scoreカラムの合計値が取得できる
# 2.user_scoresテーブルにデータがない場合は、0が取得できる

# create(:user)はspec/rails_helperに記述している設定で省略できていることに注意