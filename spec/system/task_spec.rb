require 'rails_helper'
# describe にはテスト対象、context にはテスト時の条件、it には何を確認するかを記載します。
RSpec.describe 'タスク管理機能', type: :system do
  #describe,contextはプログラムコードというよりも文章での説明
  # background doはcacybaraでサポートされているはずだがなぜかうまくいかなかったので、before do にしている。やっていることは同じ
  before do
  # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end
  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      # テストコードを it '~' do end ブロックの中に記載する
      it '作成済みのタスクが表示される' do
        task = FactoryBot.create(:task)
        visit tasks_path
        expect(page).to have_content 'デフォルトタイトル１'
      end
    end
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいる' do
        visit tasks_path
        @tasks = Task.pluck(:task_name)

        expect(@tasks[0]).to have_content 'デフォルトタイトル２'
        expect(@tasks[1]).to have_content 'デフォルトタイトル１'
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        visit new_task_path
        fill_in 'タスク', with: 'yjsn'
        fill_in '内容', with: 'con'
        click_button '登録する'
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
      end
    end
  end

end
