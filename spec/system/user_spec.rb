require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  before do
    FactoryBot.create(:user1)
    FactoryBot.create(:user2)
    FactoryBot.create(:admin_user)
    FactoryBot.create(:admin_user2)
  end
  describe 'ユーザー登録画面' do
    context 'ユーザーのデータがなくログインしていない場合' do
      it 'ユーザー新規登録のテスト' do
        visit new_user_path
        fill_in '名前', with: 'aaaa'
        fill_in 'メールアドレス', with: 'aaaa@example.com'
        fill_in 'パスワード', with: 'aaaaaaa'
        fill_in '確認用パスワード', with: 'aaaaaaa'
        click_on 'アカウントを作成する'
        expect(current_path).to eq user_path(id: 1)
      end
    end
    it 'ログインしていない時はログイン画面に飛ぶテスト' do
      visit tasks_path
      expect(current_path).to eq new_session_path
    end
  end

  describe 'ログイン画面' do
    context 'ログインしていない場合' do
      it 'ログイン機能のテスト' do
        visit new_session_path
        fill_in 'Email', with: 'sample1@example.com'
        fill_in 'Password', with: '00000000'
        click_button 'ログイン'
        expect(page).to have_content 'ログイン中'
      end
    end
    context 'ログインしている場合' do
      before do
        visit new_session_path
        fill_in 'Email', with: 'sample1@example.com'
        fill_in 'Password', with: '00000000'
        click_button 'ログイン'
      end
      it '自分の詳細画面にとべること' do
        visit user_path(id: 10000)
        expect(page).to have_content 'sampleさん'
      end
      it '他人のページは見れないこと' do
        visit user_path(id: 10001)
        expect(current_path).to eq tasks_path
      end
      it '管理者のページは見れないこと' do
        visit admin_users_path
        expect(page).to have_content 'あなたは管理者ではありません' 
      end
      it 'ログアウトできること' do
        visit user_path(id: 10000)
        click_on 'Logout'
        expect(page).to have_content 'あなたは今ログインしていません'
      end
    end
  end
  describe '管理者画面のテスト' do
    before do
      visit new_session_path
      fill_in 'Email', with: 'admin@example.com'
      fill_in 'Password', with: '00000000'
      click_button 'ログイン'
    end
    context '管理者がログインしている場合' do
      it '管理者用ページにアクセスできること' do
        visit admin_users_path
        expect(page).to have_content('管理者用ユーザーページ')
      end
      it '管理者はユーザを新規登録できること' do
        visit new_admin_user_path
        fill_in '名前', with: 'newuser'
        fill_in 'メールアドレス', with: 'newuser@mail.com'
        fill_in 'パスワード', with: 'newuser'
        fill_in '確認用パスワード', with: 'newuser'
        click_on 'アカウントを作成する'
        expect(page).to have_content('新規ユーザーを作成しました')
      end
      it '管理者用はユーザの詳細ページにアクセスできること' do
        visit admin_user_path(id: 10000)
        expect(page).to have_content 'sampleさん'
      end
      it '管理者用はユーザの編集画面からユーザを編集できること' do
        visit edit_admin_user_path(id: 10000)
        fill_in 'パスワード', with: 'newuser'
        fill_in '確認用パスワード', with: 'newuser'
        click_on 'アカウントを更新する'
        expect(page).to have_content 'ユーザーデータを更新しました'
      end
      it '管理者用はユーザの編集画面からユーザを削除できること' do
        visit admin_users_path
        page.accept_confirm do
          click_on '削除' ,match: :first
        end
        expect(page).to have_content 'ユーザーを削除しました'
      end
    end
  end
end
