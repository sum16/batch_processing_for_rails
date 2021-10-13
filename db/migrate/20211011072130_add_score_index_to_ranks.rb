class AddScoreIndexToRanks < ActiveRecord::Migration[6.1]
  def change
    # indexを追加する
    add_index :ranks, :score, name: 'ranks_score_index'
  end
end
