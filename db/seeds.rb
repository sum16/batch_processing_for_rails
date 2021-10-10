# データのリセット(子テーブル(Rank)から先に削除)
Rank.delete_all
User.delete_all

# 環境変数のUSER_AMOUNTを受け取り、文字列型から数値に変換
# この環境変数を変更することで任意の数のテストデータを作成することが可能
user_amount = ENV['USER_AMOUNT'].to_i

User.transaction do
  1.upto(user_amount) do |i|
    user = User.create(id: i, name: "#{i}人目のゲームユーザー")
    # ユーザーごとの得点
    rand(30).times do
      UserScore.create(user_id: user.id, score: rand(1..100), received_at: Time.current.ago(rand(0..60).days))
    end
  end
end

# テスト実行コード
# USER_AMOUNT=100 bin/rails db:seed 

# self から max まで 1 ずつ増やしながら繰り返します。
# 5.upto(10) {|i| print i, " " } # => 5 6 7 8 9 10

# randメソッド
# 擬似乱数を生成してくれるメソッド
# irb(main):002:0> rand(5) # 0以上5未満の整数を返す
# => 2
# irb(main):003:0> rand(1..5) # rangeで指定された範囲の値を返す
# => 5