class RanksUpdater
  def update_all

    Rank.transaction do
      # 現在のランキング情報をリセット
      Rank.delete_all
      
      create_ranks

      raise ActiveRecord::Rollback
    end
  end

  # def create_ranks  リファクタリング前
  #
  #   #2 ユーザーごとにスコアの合計を計算する
  #   user_total_scores = User.all.map do |user|
  #     { user_id: user.id, total_score: user.user_scores.sum(&:score) }
  #   end

  #   #3 ユーザーごとのスコア合計の降順に並べ替え、そこからランキング情報を再作成する
  #   sorted_total_score_groups = user_total_scores.group_by { |score| score[:total_score]}
  #   .sort_by{ |score, _| score * -1 }.to_h.values

  #   #4
  #   sorted_total_score_groups.each.with_index(1) do |scores, index|
  #     scores.each do |total_score|
  #       Rank.create(user_id: total_score[:user_id], rank: index, score: total_score[:total_score])
  #     end
  #   end

  # end
  #
  
  # 新メソッド
  def create_ranks
    RankOrderMaker.new.each_ranked_user do |user, rank|
      # ブロックのuser,rankはyeildの引数が渡される
      # ↓rank_order_maker.rbのyieldのところで実行される
      Rank.create(user_id: user.id, rank: rank, score: user.total_score)
    end
  end

end
