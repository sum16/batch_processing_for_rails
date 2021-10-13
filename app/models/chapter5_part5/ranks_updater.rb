module Chapter5Part5
  class RanksUpdater
    def update_all

      Rank.transaction do
        # 現在のランキング情報をリセット
        Rank.delete_all
        
        Development::UsedMemoryReport.instance.write('after Rank.delete_all')

        create_ranks

        Development::UsedMemoryReport.instance.write('after create_ranks')

        update_ranks

        Development::UsedMemoryReport.instance.write('after update_ranks')
      end
    end
  
    # ユーザーごとのスコア合計を降順に並べ替え、そこからランキング情報を再作成する
    def create_ranks

      Development::UsedMemoryReport.instance.write('after Rank.import')

      # 処理を２つに分ける
      User.includes(:user_scores).find_in_batches(batch_size: 100) do |users|
        Rank.import users
        .select { |user| user.total_score.nonzero? }
        .map { |user| { user_id: user.id, score: user.total_score }  }
      end
    end

    def update_ranks
      RankOrderMaker.new.each_ranked_user do |score, rank|
        Rank.where(score: score).update_all(rank: rank)
      end
    end
  end
end

# ・find_in_batchsメソッド
# 分割してレコードを取得して処理
# デフォルトで1000件ずつ処理

# 使い方
# モデル.find_in_batches([オプション]) do |i|
#   処理内容
# end

# オプション
# オプション	説明	デフォルト値
# :batch_size	同時処理数	1000
# :start	処理開始位置	 
# :finish	終了するときのキー	 
# :error_on_ignore	例外を発生させる	 


# find_in_batchesはパラメーターのbatch_sizeで指定した件数ずつテーブルからデータを読み込み、ブロック引数の中で取得したデータをmodelの配列として利用することができます。
# 今回の場合はfind_in_batches(batch_size: 100)としたことで100件ずつusersテーブルのデータを取得
# 取得結果はブロックの中でusersとして利用することができる

# usersは以下のコードのように、select { |user| user.total_score.nonzero? }でスコアを所有しているユーザーのみを抽出し、その後.map { |user| { user_id: user.id, score: user.total_score } }でranksテーブルに挿入するデータの配列を作成

# その内容をRank.importで挿入している