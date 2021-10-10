module Development
  class UsedMemoryReport
    # Singletonモジュールを使用, 組み込みモジュールはincludeで読み込み
    include Singleton

    # initializeで初期化した@reports変数にはwriteメソッド内で実行しているObjectSpace.memsize_of_allの結果が追記されている
    def initialize
      @reports = []
    end

    def write(label)
      @reports << "used memory: #{label} #{ObjectSpace.memsize_of_all * 0.001 * 0.001} MB"
    end

    def puts_all
      @reports.each { |report| puts report }
    end
  end
end

# Rubyは標準の機能としてSingletonモジュールが提供
# Singletonモジュールを使用するとデザインパターンのひとつであるSingletonパターンを簡単に取り入れることが可能
# SingletonパターンはGoFのデザインパターンのひとつで広く知れ渡っているプログラミングの手法で、
# このパターンを適用すると、クラスのインスタンスはプログラムの中でひとつだけに限定される。
# 今回のように、メモリ消費量の結果を*ひとつのインスタンス変数*に追記したい場合などに利用すると便利なデザインパターン

# ary = [1]
# ary << 2
# p ary      # [1, 2]