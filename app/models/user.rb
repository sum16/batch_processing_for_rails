class User < ApplicationRecord
  has_many :user_scores
  has_one :rank

  def total_score
    @total_score ||= user_scores.sum(&:score)
  end

end

# インスタンス変数 ||=を使用すると計算結果のキャッシュを保持することができ、メソッドが2回目以降に呼び出されたときの速度向上が期待できる