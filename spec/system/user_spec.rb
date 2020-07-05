require 'rails_helper'
RSpec.describe 'ユーザ登録・ログイン・ログアウト機能', type: :system do
  describe 'ユーザ登録のテスト' do
    context 'ユーザのデータがなくログインしていない場合' do
      it 'ユーザ新規登録のテスト' do
        visit new_user_path
        fill_in 'user[name]', with: 'new_user'
        fill_in 'user[email]', with: 'new_user@example.com'
        fill_in 'user[password]', with: '12345678'
        fill_in 'user[password_confirmation]', with: '12345678'
        click_on 'アカウント作成'
        expect(current_path).to eq user_path(id: @user.id)
      end
      it 'ログインしていない時はログイン画面に飛ぶテスト' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end
  describe 'セッション機能のテスト' do
    before do
      FactoryBot.create(:user)
    end
    context 'ログインのテスト' do
      it 'ログインができること' do
        new_session_path
        fill_in 'session[name]', with: 'sample@example.com'
        fill_in 'session[password]', with: '00000000'
        click_on 'Log in'
        expect(current_path).to eq user_path(id: @user.id)
      end
    end
  end
end
