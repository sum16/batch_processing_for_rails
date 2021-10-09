# 順位を決める機能を担当
class RankOrderMaker

  def each_ranked_user
    # 変数の初期化
    # rankは順位を格納する変数で最初は1からはじめる previous_scoreはrankの変数を更新すべきかを判定するために使用
    rank = 1
    privious_score = 0

    # 全ユーザーの中からスコアを獲得しているユーザーを選択し、合計スコアの高い順に並び替え
    users_sorted_by_score.each do |user|
      # 合計スコアが変わった場合は順位を更新
      rank += 1 if user.total_score < privious_score

      # app/models/ranks_updater.rb の create_ranksに書いた
      # Rank.create(user_id: user.id, rank: rank, score: user.total_score) を実行
      yield(user,rank)
      
      # previous_scoreを更新して、次の順位更新に備える
      privious_score = user.total_score
    end
  end

  private

  def users_sorted_by_score
    # selectで絞り込み,sort_byで降順に
    User.all
    .select{ |user| user.total_score.nonzero? }
    .sort_by { |user| user.total_score * -1 }

    #total_score = Userクラスのインスタンスメソッド
  end
end

# nonzero? 自身がゼロの時 nil を返し、非ゼロの時 self を返す

# selectメソッドは条件式に一致した要素を取得するためのメソッド

# 配列オブジェクト.select { |変数| ブロック処理 }

# yieldを使うとメソッドを呼び出す側が任意のコードをブロック引数として渡し、メソッド内のyieldと書いたところで実行することが可能