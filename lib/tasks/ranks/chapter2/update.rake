namespace :ranks do
  namespace :chapter2 do
    desc 'chapter2 ゲーム内のユーザーランキング情報を更新する'
    # ※1
    task update: :environment do
      #1 現在のランキング情報をリセット
      # Rank.delete_all

      #2 ユーザーごとにスコアの合計を計算する
      user_total_scores = User.all.map do |user|
        { user_id: user.id, total_score: user.user_scores.sum(&:score) }
      end


      #3 ユーザーごとのスコア合計の降順に並べ替え、そこからランキング情報を再作成する
      sorted_total_score_groups = user_total_scores.group_by { |score| score[:total_score]}
      .sort_by{ |score, _| score * -1 }.to_h.values
    end

    desc 'chapter2 ゲーム内のユーザーランキング情報をリセットする'
    task reset: :environment do
      
    end
  end

end


# ※1-1
# update: :environmentという書き方はrakeの設定方法で、二つのタスクの実行順を定義し、連続して実行させることができる
# {タスクA}: :{タスクAの前に実行するタスクB}
# 今回の場合は先に:environmentタスクが実行され、次に:updateタスクが実行される
# :environmentはRailsが提供しているタスクのひとつ
# config/environment.rbを読み込み、productionやdeveropmentといった実行環境ごとの設定を反映している
# namespaceを定義すると、バッチ処理を実行するときのコマンド名を修飾することができる → namespaceを使って何のupdateであるのかを表現

# 1-2
# p user_total_scores
# →[{:user_id=>1, :total_score=>8}, {:user_id=>2, :total_score=>8}, {:user_id=>3, :total_score=>3}, {:user_id=>4, :total_score=>1}, {:user_id=>5, :total_score=>9}]

# 1-3 処理の流れ  
# 上記のuser_total_scoresがまず|score|に入り、score[:total_score]、つまりスコアの数字(3や8)ごとにグループ化をしている。同じtotal_scoreのハッシュをグルーピングしている
# p sorted_total_score_groupsで変数をのぞいてみると
# {8=>[{:user_id=>1, :total_score=>8}, {:user_id=>2, :total_score=>8}], 3=>[{:user_id=>3, :total_score=>3}], 1=>[{:user_id=>4, :total_score=>1}], 9=>[{:user_id=>5, :total_score=>9}]}

# scoreに-1を掛けた値を基準に昇順で並び替えれば、降順での並び替えを実行することが可能 並び替えの条件に-1をかけることで-5,-4,-3..となり、実際のスコアは5,4,3..と降順になる
# sort_byのブロックはハッシュの値を|キー, 値|の形で受け取りますが、並び替えに値は使用していません。今回の値だと{:user_id=>1, :total_score=>8}など..
# Rubyではブロック内で未使用の値はアンダースコア（_）の記号にする慣習があります。
# 実際、そのほうが未使用であることが明示的に伝わるため読みやすいコードになるでしょう。

# sort_byを加えた上でデバックすると
# [[9, [{:user_id=>5, :total_score=>9}]], [8, [{:user_id=>1, :total_score=>8}, {:user_id=>2, :total_score=>8}]], [3, [{:user_id=>3, :total_score=>3}]], [1, [{:user_id=>4, :total_score=>1}]]]
# と配列なり２次元配列になっていることがわかる
# to_hをつけると　{9=>[{:user_id=>5, :total_score=>9}], 8=>[{:user_id=>1, :total_score=>8}, {:user_id=>2, :total_score=>8}], 3=>[{:user_id=>3, :total_score=>3}], 1=>[{:user_id=>4, :total_score=>1}]}
# valuesでハッシュの値のみを取得 デバックすると
# [[{:user_id=>5, :total_score=>9}], [{:user_id=>1, :total_score=>8}, {:user_id=>2, :total_score=>8}], [{:user_id=>3, :total_score=>3}], [{:user_id=>4, :total_score=>1}]]