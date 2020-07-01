## Name
todomanagement

## Overview
Todo管理アプリ　
## Description
このアプリはTodoアプリです。タスクを登録し、終了期限、優先順位をつけて管理できます。必要であればラベルをつけることもできます。
また、タスク名、ラベル名で検索することができます。
## composition
- ruby version 2.6.5
- rails version 5.2.4
- database Postgresql

usersテーブル

| カラム   | データ型 |
| ----   | ------ |
|  id    | integer|
|  name  | string |

tasksテーブル

| カラム   | データ型 |
| ----   | ------ |
|  id    | integer|
|  task_name  | string |
| content | text |
| time_limit | date |
| priority | string |
| user_id | bigint |

labels テーブル

| カラム   | データ型 |
| ----   | ------ |
|  id    | integer|
| status | string |

labelings テーブル

| カラム   | データ型 |
| ----   | ------ |
|  id    | integer|
| task_id | bigint |
| label_id| bigint |

## 自動化を含めたherokuへのデプロイ手順
1. アセットプリコンパイルをしてファイルを連結。本番環境で動作するようにする
  $ rails assets:precompile RAILS_ENV=production
2. herokuへログイン
  $ heroku login
3. コミットする
  $ git add .
  $ git commit -m"herokuへデプロイする"
4. herokuにアプリケーションを作成する。（アプリを入れる空の入れ物を作っている）
  $ heroku create
5. heroku buildpackを追加する。しなくても動くかもしれない。やっておくのが無難
  $ heroku buildpacks:set heroku/ruby
  $ heroku buildpacks:add --index 1 heroku/nodejs
6. herokuへデプロイする
  ①masterブランチの場合
    $ git push heroku master
  ②masterブランチ以外からherokuへ送る場合
    $ git push heroku step2:master
7. データベースを移行し、動くようにする
  $ heroku run rails db:migrate
8. herokuへアクセス
  $ heroku open
9. Githubと連携する
  ①herokuのダッシュボードにアクセスする
  ②githubと連携するアプリを選択する
  ③Deployタブを選択する
  ④[Deployment method]セクションで[GitHub]を選択し、[Connect to GitHub]セクションの[Connect   to GitHub]をクリックする
  ⑤[Connect to GitHub]で連携するリポジトリを検索・選択して [Connect]をクリックする
  ⑥[Automatic deploys]セクションでデプロイするブランチを選択して [Enable Automatic Deploys]をクリックする
  ⑦ソースコードを変更してGitHubにpushする
  ⑧連携できているかアプリのページへいき、buildログを確認する

## Author
2005 onoshin
