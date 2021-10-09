require 'rails_helper'

  RSpec.describe User,type: :model do
    describe '#total_score' do
      # FactoryBot
      let(:user1) { create(:user) }

      before do
        create(:user_score, user: user1, score:4)
        create(:user_score, user: user1, score:5)
        create(:user_score, user: user1, score:6)
      end
      
      it 'スコアの合計値を取得できる' do
        expect(user1.total_score).to eq 15
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