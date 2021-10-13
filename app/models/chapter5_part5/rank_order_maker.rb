module Chapter5Part5
  class RankOrderMaker

    def each_ranked_user
      Rank.distinct(:score).order(score: :desc).pluck(:score)
      .each.with_index(1) do |score, index|
        yield(score, index)
      end
    end

  end
end

# SELECTの実行結果からscoreの重複を排除して取得する
# scoreの降順(合計スコアの高い順)に並び替える
# yieldでブロック引数として渡された処理をscoreごとに実行

# pluckメソッドとは、引数に指定したカラムの値を配列で返してくれるメソッド
# pluck(:score)はscoreのみを配列で取得する
# pluckを使わない場合はActiveRecordのRankインスタンスを取得しますが、目的のカラムのデータのみを抜き出すpluckはメモリ消費量や実行時間の点で優れている

# each.with_index(1)でscoreごとに繰り返し処理を実行するなかでyieldを実行し、ブロック引数として渡されたコードを実行するようにしている