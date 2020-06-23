require 'rails_helper'
# describe にはテスト対象、context にはテスト時の条件、it には何を確認するかを記載します。
RSpec.describe 'タスク管理機能', type: :system do
  #describe,contextはプログラムコードというよりも文章での説明
  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      # テストコードを it '~' do end ブロックの中に記載する
      it '作成済みのタスクが表示される' do
        task = FactoryBot.create(:task, task_name: 'task', content: 'test_content')
        visit tasks_path
        expect(page).to have_content 'task'
        expect(page).to have_content 'test_content'
      end
    end
  end
  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        visit new_task_path
        fill_in 'Task name', with: 'yjsn'
        fill_in 'Content', with: 'con'
        click_button 'Create Task'
        expect(page).to have_content 'yjsn'
        expect(page).to have_content 'con'
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
        #byebug
      end
    end
  end

end
