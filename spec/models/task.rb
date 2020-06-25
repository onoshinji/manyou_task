require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :model do
  #バリデーションが働いているか確かめるためにわざと空白のタスクネームをつけ、マッチャでnot_to be_validを使って確かめている
  describe '#task_nameカラム' do
    context 'タスクを作成したとき' do
      it 'task_nameが空ならバリデーションが通らない' do
        task = Task.new(task_name: '', content: '失敗テスト')
        expect(task).not_to be_valid
      end
      it 'task_nameが81字以上ならバリデーションが通らない' do
        task = Task.new(task_name: '01234567890123456789
                                    0123456789012345678901234',
                        content: '8１文字検証テスト')
        expect(task).not_to be_valid
      end
    end
  end

  describe '#contentカラム' do
    context 'タスクを作成したとき' do
      it 'contentが空ならバリデーションが通らない' do
        task = Task.new(task_name: 'コンテントバリデーションテスト', content: '')
        expect(task).not_to be_valid
      end
      it 'contentが301字以上ならバリデーションが通らない' do
        task = Task.new(task_name: '３０１文字以上検証',
                        content: '01234567890123456789
                                  01234567890123456789
                                  01234567890123456789
                                  01234567890123456789
                                  01234567890123456789
                                  01234567890123456789
                                  01234567890123456789')
        expect(task).not_to be_valid
      end
    end
  end

  describe '#task_name&&contentカラム' do
    context 'タスクを作成したとき' do
      it 'titleとcontentに内容が記載されていればバリデーションが通る' do
        task = Task.new(task_name: 'タスク', content: 'コンテント')
        expect(task).to be_valid
      end
    end
  end
end
