# バッチ処理を用いてデータの一括更新をする

# 仕様
ユーザーごとにスコアの合計が計算・記録される  
バッチ処理を再実行したときは、これまでの結果はすべてリセットされ新しい結果が記録される  
スコアを獲得していないユーザーの情報は記録されない  


# ER図
![ER図](https://user-images.githubusercontent.com/66477859/133884329-6adb4de4-4440-426e-8d4e-5122866ad244.png)  
  
  
## lib/tasks/ranksファイルにバッチ処理を定義  
  
  
## Setup
  
※ Mysqlコンテナ立ち上げ  
docker-compose up -d  
  
※ batch_processing_for_rails_devに接続  
mysql -h 127.0.0.1 -u root -p batch_processing_for_rails_dev  
  
※ テーブル情報を表示  
mysql -h 127.0.0.1 -u root -p batch_processing_for_rails_dev -e'SELECT * FROM users'  
  
※ テストデータへアクセス  
mysql -h 127.0.0.1 -u root -p batch_processing_for_rails_test -e'SELECT * FROM users'


## 使用コマンド  

実行可能なrailsのコマンドが一覧として表示、その中に**rakeファイルに定義したコマンド**がある  
bin/rails -vT  
  
タスク実行  
bin/rails ranks:chapter2:update
  
テスト実行  
bundle exec rspec -f d  
（-f dでテスケースごとの説明や詳細を表示してくれる  
  
log/development.logなどのログファイルを削除し、これまでに蓄積されたログをリセット
bin/rails log:clear  
  
ログファイルの中身を確認
less -R log/development.log  
  
キーボードの↓キーと↑キーで1行ずつ上下に移動
キーボードのbで1画面分戻る
キーボードのfで1画面分先に進む
キーボードのGでファイルの末尾に移動する
キーボードのgでファイルの先頭に移動する
/{検索したいキーワード}で単語検索。nキーで次の検索結果に移動
?{検索したいキーワード}で逆方向から単語検索。nキーで次の検索結果に移動  
  
ファイルの最後の部分を一定量表示してくれるコマンド  
tail log/development.log  
  
テスト実行  
USER_AMOUNT=100 bin/rails db:seed 

