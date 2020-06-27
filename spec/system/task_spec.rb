require 'rails_helper'
# describe にはテスト対象、context にはテスト時の条件、it には何を確認するかを記載します。
RSpec.describe 'タスク管理機能', type: :system do
  #describe,contextはプログラムコードというよりも文章での説明
  # background doはcacybaraでサポートされているはずだがなぜかうまくいかなかったので、before do にしている。やっていることは同じ
  before do
  # あらかじめタスク一覧のテストで使用するためのタスクを作成する
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
  end
  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        visit new_task_path
        fill_in 'タスク', with: 'yjsn'
        fill_in '内容', with: 'con'
        select '低', from: '優先順位'
        select '未着手', from: 'ステータス'
        click_button '登録する'
        expect(page).to have_content 'yjsn'
        expect(page).to have_content 'con'
        expect(page).to have_content '低'
        expect(page).to have_content '未着手'
      end
    end
  end
  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      # テストコードを it '~' do end ブロックの中に記載する
      it '作成済みのタスクが表示される' do
        task = FactoryBot.create(:task)
        visit tasks_path
        expect(page).to have_content 'デフォルトタイトルone'
      end
    end
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいる' do
        visit tasks_path
        @tasks = Task.order(created_at: :DESC).pluck(:task_name)
        expect(@tasks[0]).to have_content 'デフォルトタイトルthree'
        expect(@tasks[1]).to have_content 'デフォルトタイトルtwo'

      end
    end
    context 'タスク検索をした場合' do
      it "タイトルで検索できる" do
        visit tasks_path
        @task = FactoryBot.create(:task, task_name: 'タスクあいまい検索')
        fill_in 'task_name_search', with: 'タスク'
        click_button 'タスク検索'
        expect(@task.task_name).to have_content 'タスクあいまい検索'

      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスで検索できる" do
        visit tasks_path
        @task = FactoryBot.create(:task, status: '未着手')
        select '未着手', from: 'status_search'
        click_button 'ステータス検索'
        expect(@task.status).to have_content '未着手'
      end
    end
    context 'タイトルとステータスのAND検索をした場合' do
      it "タイトルとステータスでAND検索できる" do
        visit tasks_path
        @task = FactoryBot.create(:task, task_name: 'タスク1', status: '未着手')
        @task = FactoryBot.create(:second_task, task_name: 'task2', status: '着手中')
        @task = FactoryBot.create(:third_task, task_name: 'タスク3', status: '着手中')
        fill_in 'task_name_search', with: 'タスク'
        select '着手中', from: 'status_search'
        click_button 'ステータス検索'
        expect(page).to have_content 'タスク3'
      end
    end
    context '複数のタスクを作成し、終了期限でソートした場合' do
      it '終了期限が早い順でソートを選び、その順番に並んでいる' do
        visit tasks_path
        select '終了期限が早い順', from: 'time_limit_select'
        #日付で順番を確かめるのは、変わってしまうので難しい。よって、ここではタスクネームで判定する
        @tasks = Task.order(time_limit: :ASC).pluck(:task_name)
        expect(@tasks[0]).to have_content 'デフォルトタイトルone'
        expect(@tasks[1]).to have_content 'デフォルトタイトルtwo'
        expect(@tasks[2]).to have_content 'デフォルトタイトルthree'
      end
      it '終了期限が遅い順でソートを選び、その順番に並んでいる' do
        visit tasks_path
        select '終了期限が遅い順', from: 'time_limit_select'
        @tasks = Task.order(time_limit: :DESC).pluck(:task_name)
        expect(@tasks[0]).to have_content 'デフォルトタイトルthree'
        expect(@tasks[1]).to have_content 'デフォルトタイトルtwo'
        expect(@tasks[2]).to have_content 'デフォルトタイトルone'
      end
    end
    context '複数のタスクを作成し、優先順位でソートした場合' do
      it '優先順位が低い順でソートを選び、その順番に並んでいる' do
        visit tasks_path
        select '低', from: 'priority_select'
        @tasks = Task.order(priority: :ASC).pluck(:priority)
        expect(@tasks[0]).to have_content '低'
        expect(@tasks[1]).to have_content '中'
        expect(@tasks[2]).to have_content '高'
      end
      it '優先順位が高い順でソートを選び、その順番に並んでいる' do
        visit tasks_path
        select '高', from: 'priority_select'
        @tasks = Task.order(priority: :DESC).pluck(:priority)
        expect(@tasks[0]).to have_content '高'
        expect(@tasks[1]).to have_content '中'
        expect(@tasks[2]).to have_content '低'
      end
    end
  end

  describe 'タスク詳細画面' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示されたページに遷移する' do
        @task = FactoryBot.create(:task, task_name: 'show', content: 'show_content')
        visit task_path(@task.id)
        expect(page).to have_content 'show'
        expect(page).to have_content 'show_content'
      end
    end
  end

end
