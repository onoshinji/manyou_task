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
  - "Users" table 
    - id
    - name
  - "tasks" table
    - id
    - task_name
    - time_limit
    - priority
    - user_id
  - "labels" table
    - id
    - status
  - "labelings" table
    - id
    - task_id
    - label_id

## Author
onoshin
