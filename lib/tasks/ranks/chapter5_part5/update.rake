require 'objspace'

namespace :ranks do
  namespace :chapter5_part5 do
    desc 'chapter3 ゲーム内のユーザーランキング情報を更新する'
    task update: :environment do
      
      #モジュール名::クラス名で参照
      Development::UsedMemoryReport.instance.write('start batch')

      # 実行時間を測定するためにBenchmarkを使用
      Benchmark.bm 10 do |r|
        r.report 'RanksUpdater' do
          Chapter5Part5::RanksUpdater.new.update_all
        end
      end
      
      Development::UsedMemoryReport.instance.write('end batch')
      Development::UsedMemoryReport.instance.puts_all
    end
  end
end

## 実行時間を測定
# 10のパラメーターは出力結果1行目のラベルごとの文字幅を指定しています。
# あとは実行時間を測定したいコードをr.report 'RanksUpdater'で囲むことで測定対象が設定されます。
# r.reportの引数'RanksUpdater'は測定結果に表示するラベルを指定しています。
# 今回は測定対象がひとつのみですがr.reportは複数設定することができ、ラベルをつけておくとどの処理の実行時間であるかがわかりやすくなります。


## メモリ消費量を測定する
# ObjectSpace.memsize_of_allは実行時点の消費メモリ量をバイト単位で取得することができるメソッド
# Rubyに標準で提供されているライブラリobjspaceの機能のひとつ
# バイト単位ではわかりにくいため、今回は以下のように0.001を二回掛けることでメガバイト単位で表示

# Singletonモジュール
# Singletonモジュールを読み込んだクラスのインスタンスを利用するときはnewではなく、instanceを使用する
# Development::UsedMemoryReport.instanceとすることで、バッチ処理実行中の
# Development::UsedMemoryReportクラスのインスタンスはどこから利用してもひとつの同じインスタンスを参照する