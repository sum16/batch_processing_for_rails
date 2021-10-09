require 'rails_helper'

RSpec.describe RanksUpdater, type: :model do
  describe '#update_all' do

    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:user3) { create(:user) }

    before do
      create(:user_score, user: user1, score: 3)
      create(:user_score, user: user1, score: 2)
      create(:user_score, user: user1, score: 1)

      create(:user_score, user: user2, score: 10)
      create(:user_score, user: user2, score: 3)
      create(:user_score, user: user2, score: 4)

      create(:user_score, user: user3, score: 1)
      create(:user_score, user: user3, score: 1)
      create(:user_score, user: user3, score: 1)
    end

    shared_examples 'ランキング情報更新処理の検証' do
      it 'ranksテーブルにデータが作成される' do
        RanksUpdater.new.update_all

        expect(Rank.count).to eq 3
        ranks = Rank.all.order(:rank)

        # ランク順に並んでいるため、user2のスコア合計17が一番
        expect(ranks[0].user.id).to eq user2.id
        expect(ranks[0].rank).to eq 1
        expect(ranks[0].score).to eq 17

        expect(ranks[1].user.id).to eq user1.id
        expect(ranks[1].rank).to eq 2
        expect(ranks[1].score).to eq 6

        expect(ranks[2].user.id).to eq user3.id
        expect(ranks[2].rank).to eq 3
        expect(ranks[2].score).to eq 3
      end
    end

    context 'ranksテーブルにまだデータが存在していない場合' do
      it 'ranksテーブルにデータが作成される' do
        RanksUpdater.new.update_all
        
        expect(Rank.count).to eq 3
        
        ranks = Rank.all.order(:rank)
        expect(ranks[0].user_id).to eq user2.id
        expect(ranks[0].rank).to eq 1
        expect(ranks[0].score).to eq 17
        
        expect(ranks[1].user_id).to eq user1.id
        expect(ranks[1].rank).to eq 2
        expect(ranks[1].score).to eq 6
        
        expect(ranks[2].user_id).to eq user3.id
        expect(ranks[2].rank).to eq 3
        expect(ranks[2].score).to eq 3
      end
      include_examples 'ランキング情報更新処理の検証'
    end

    context 'ranksテーブルにすでにデータが存在している場合' do
      before do
        create(:rank, user: user1, rank: 3, score: 10) 
        create(:rank, user: user2, rank: 2, score: 20)
        create(:rank, user: user3, rank: 1, score: 31)
      end

      include_examples 'ランキング情報更新処理の検証'
      # ラベルを記述し忘れないように注意
    end


  end
end

# 基本の検証項目
# ranksテーブルにユーザーごとのランキング情報が記録されていること
  # 場合分け
  # ranksテーブルにまだデータが存在していない場合
  # ranksテーブルにすでにデータが存在している場合

  # shared_examplesで共通部分を切り出す
  # shared_examplesを使用するとテストコードの一部を共通化して、複数のテストケースで利用することが可能になる
  # 共通化したいコードをshared_examplesの中に定義していく
  # 今回はit 'ranksテーブルにデータが作成される'のテストコードをshared_examplesに移動して共通化している
  # shared_examplesはinclude_examplesで呼び出すことができる
  # shared_examplesで設定しているラベル(今回は*ランキング情報更新処理の検証*)を指定するとshared_examplesの中身を呼び出してテストが実行される
  # 共通化できる部分をshared_examplesで設定し、あとはcontextごとの差分を書く