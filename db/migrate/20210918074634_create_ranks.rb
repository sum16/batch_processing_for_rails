class CreateRanks < ActiveRecord::Migration[6.1]
  def change
    create_table :ranks, comment: 'ゲーム内のランキング情報' do |t|
      t.references :user, null: false, index: true, foreign_key: { on_delete: :restrict, on_update: :restrict }, comment: 'ユーザー'
      # 子テーブルから先にデータを削除しないとエラーになる(on_delete=トリガー、内容=restrict) sql参照
      t.integer :rank, null: false, default: 0, index: true, comment: 'ユーザーの順位'
      t.integer :score, null: false, default: 0, comment: 'このランクに至ったスコア'

      t.timestamps null: false
    end
  end
end
