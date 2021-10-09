require 'rails_helper'

RSpec.describe RankOrderMaker, type: :model do
  # each_ranked_userメソッドのテスト
  describe '#each_ranked_user' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:user3) { create(:user) }

    context '同じ合計スコアのユーザーが存在しない場合' do

    end

    context '同じ合計スコアのユーザーが複数存在した場合' do
      before do
        create(:user_score, user: user1, score: 4)
        create(:user_score, user: user1, score: 5)
        create(:user_score, user: user1, score: 6)

        create(:user_score, user: user2, score: 4)
        create(:user_score, user: user2, score: 5)
        create(:user_score, user: user2, score: 6)

        create(:user_score, user: user3, score: 10)
        create(:user_score, user: user3, score: 11)
        create(:user_score, user: user3, score: 12)
      end

      it 'スコアの高い順(降順)にuserとrankを取得できる' do
        orders = {}
        # rankの値をuser.idをキーとしてハッシュに保存
        RankOrderMaker.new.each_ranked_user do |user, rank|
          orders[user.id] = rank
          p user
          p rank
          p orders
        end

        expect(orders.size).to eq 3
        expect(orders[user3.id]).to eq 1
        expect(orders[user2.id]).to eq 2
        expect(orders[user1.id]).to eq 2
      end
    end

    context 'スコアを獲得していないユーザーが存在する場合' do
      before do
        create(:user_score, user: user1, score: 4)
        create(:user_score, user: user1, score: 5)
        create(:user_score, user: user1, score: 6)

        create(:user_score, user: user2, score: 7)
        create(:user_score, user: user2, score: 8)
        create(:user_score, user: user2, score: 9)

        create(:user_score, user: user3, score: 10)
        create(:user_score, user: user3, score: 11)
        create(:user_score, user: user3, score: 12)

        # スコアを獲得していないユーザーを作成する
        create(:user)
      end

      it 'スコアの高い順(降順)にuserとrankを取得できる' do
        orders = {}

        RankOrderMaker.new.each_ranked_user do |user, rank|
          orders[user.id] = rank
        end

        expect(orders.size).to eq 3
        expect(orders[user3.id]).to eq 1
        expect(orders[user2.id]).to eq 2
        expect(orders[user1.id]).to eq 3
      end
    end

  end
end


# 基本の検証項目
# ユーザーへ合計スコアに応じた順位が設定されていること
# ブロック引数に渡した処理が実行されていること
# 場合分け
# 同じ合計スコアのユーザーが存在しない場合
# 同じ合計スコアのユーザーが複数存在した場合
# スコアを獲得していないユーザーが含まれている場合

# ordersハッシュへ値が格納できるということは基本の検証項目のひとつ、ブロック引数に渡した処理が実行されていることが実現できているということになる