# バッチ処理を用いてデータの一括更新をする

# 仕様
ユーザーごとにスコアの合計が計算・記録される  
バッチ処理を再実行したときは、これまでの結果はすべてリセットされ新しい結果が記録される  
スコアを獲得していないユーザーの情報は記録されない  


# ER図
![ER図](https://user-images.githubusercontent.com/66477859/133884329-6adb4de4-4440-426e-8d4e-5122866ad244.png)  
  
  
## lib/tasks/ranksファイルにバッチ処理を定義  
  
  
## 使用コマンド
実行可能なrailsのコマンドが一覧として表示、その中に**rakeファイルに定義したコマンド**がある  
bin/rails -vT  
  
タスク実行  
bin/rails ranks:chapter2:update
  

