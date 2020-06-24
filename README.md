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

## Author
2005 onoshin
