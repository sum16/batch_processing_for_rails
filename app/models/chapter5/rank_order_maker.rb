module Chapter5
  class RankOrderMaker

    # 各ユーザーを合計スコアの高い順に並び替えて順位を設定し、ブロック引数に設定された処理をユーザーごとに実行するためのメソッド
    def each_ranked_user
      rank = 1
      previous_score = 0

      # 全ユーザーの中からスコアを獲得しているユーザーを選択し、合計スコアの高い順に並び替え
      users_sorted_by_score.each do |user|
        rank += 1 if user.total_score < previous_score
        yield(user, rank)
        
        # previous_scoreを更新して、次の順位更新に備える
        previous_score = user.total_score
      end
    end

    private

    def users_sorted_by_score
      User.includes(:user_scores)
      .all
      .select { |user| user.total_score.nonzero? }
      .sort_by { |user| user.total_score * -1 }
    end
  end
end

# nonzero? 自身がゼロの時 nil を返し、非ゼロの時 self を返す

# selectメソッドは条件式に一致した要素を取得するためのメソッド

# 配列オブジェクト.select { |変数| ブロック処理 }

# yieldを使うとメソッドを呼び出す側が任意のコードをブロック引数として渡し、メソッド内のyieldと書いたところで実行することが可能