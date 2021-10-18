class User < ApplicationRecord
  has_many :user_scores
  has_one :rank

  # ユーザーごとのスコアの合計値を返す
  def total_score
    @total_score ||= user_scores.sum(&:score)
  end

end

# インスタンス変数 ||=を使用すると計算結果のキャッシュを保持することができ、メソッドが2回目以降に呼び出されたときの速度向上が期待できる

# 自己代入
# nilまたは、falseであれば、||=の右辺にある値を変数に代入する。
# nilまたは、false以外であれば、変数の値をそのまま利用する。このイディオムは変数の初期化で良く用いられる
# a ||= true