class CreateUserScores < ActiveRecord::Migration[6.1]
  def change
    create_table :user_scores, comment: 'ユーザーがゲーム内で獲得した点数' do |t|

      # 対象テーブルを先頭から順にシーケンシャルに探していく（＝インデックスのない状態）
      # インデックスを参照して該当レコードのIDを調べる。（＝インデックスのある状態
      t.references :user, null: false, index: true, foreign_key: { on_delete: :cascade, on_update: :cascade }, comment: 'ユーザー'
      t.integer :score, null: false, default: 0, comment: 'ユーザーが獲得した点数'
      t.datetime :received_at, null: false, index: true, comment: '点数を獲得した日時'

      t.timestamps null: false
    end
  end
end

# WHEREやJOINで使用される → インデックス候補
# インデックスは特定のカラムから該当するレコードを探すために使用されるので、WHEREやJOINで指定されるカラムはインデックス候補となる。

# レコード件数が1万件を超えるテーブル → インデックス候補
# レコード件数が少ない場合、インデックスによる検索よりシーケンシャルな全件検索の方が早い場合がある。
# 明確な閾値ではありませんので、1万件は目安

# 外部キー → インデックス候補
# MySQLの場合、外部キーを作成すると自動的にインデックスが作成されます。

# カーディナリティが20以上 → インデックス候補
# カーディナリティとは、カラムに設定される値の種類の数です。下記テーブルのageに設定される値の種類は20と25の二種類なので、カーディナリティは2となる。
# カーディナリティが小さいと、一つの値に多くのレコードが紐づくことになるため、結局探すのに時間がかかることになる。

# ---------------

# on_deleteを指定すると削除時がトリガーとなる。cascadeで参照元が削除された場合、参照しているテーブルを削除するようになる
# on_update
# on_delete