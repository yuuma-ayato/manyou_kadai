require 'rails_helper'
RSpec.describe 'ユーザ登録・ログイン・ログアウト機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @admin_user = FactoryBot.create(:admin_user)
  end
  describe 'ユーザ登録のテスト' do
    context 'ユーザのデータがなくログインしていない場合' do
      it 'ユーザ新規登録のテスト' do
        visit new_user_path
        fill_in 'user[name]', with: 'new_user'
        fill_in 'user[email]', with: 'new_user@example.com'
        fill_in 'user[password]', with: '12345678'
        fill_in 'user[password_confirmation]', with: '12345678'
        click_on 'アカウント作成'
        expect(page).to have_content 'new_user'
      end
      it 'ログインしていない時はログイン画面に飛ぶテスト' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe 'セッション機能のテスト' do
    context "ユーザのデータがありログインしていない場合" do
      it 'ログインができること' do
        visit new_session_path
        fill_in 'session[email]', with: @user.email
        fill_in 'session[password]', with: @user.password
        click_on 'Log in'
        expect(current_path).to eq user_path(id: @user.id)
      end
    end
    context "ユーザのデータがありログインしている場合" do
      before do
        visit new_session_path
        fill_in 'session[email]', with: @user.email
        fill_in 'session[password]', with: @user.password
        click_on 'Log in'
      end
      it "自分の詳細画面に飛べること" do
        visit user_path(id: @user.id)
        expect(current_path).to eq user_path(id: @user.id)
      end

      it "一般ユーザが他人の詳細画面に飛ぶとタスク一覧ページに遷移すること" do
        visit user_path(id: @admin_user.id)
        expect(page).to have_content "他の人のページへアクセス出来ません"
      end

      it "ログアウトができること" do
        visit user_path(id: @user.id)
        click_on "Logout"
        expect(page).to have_content "ログアウトしました"
      end
    end
  end

  describe "管理画面のテスト" do
    context "管理者ユーザのデータがありログインしていない場合" do
      it "管理者は管理画面にアクセスできること" do
        visit new_session_path
        fill_in 'session[email]', with: @admin_user.email
        fill_in 'session[password]', with: @admin_user.password
        click_on "Log in"
        visit admin_users_path
        expect(page).to have_content "管理者画面"
      end
    end

    context "一般ユーザーでログインしている場合" do
      it "一般ユーザは管理画面にアクセスできないこと" do
        visit new_session_path
        fill_in 'session[email]', with: @user.email
        fill_in 'session[password]', with: @user.password
        click_on "Log in"
        visit admin_users_path
        expect(page).to have_content "あなたは管理者ではありません"
      end
    end

    context "管理者でログインしている場合" do
      before do
        visit new_session_path
        fill_in 'session[email]', with: @admin_user.email
        fill_in 'session[password]', with: @admin_user.password
        click_on "Log in"
        visit admin_users_path
      end

      it "管理者はユーザを新規登録できること" do
        click_link "ユーザ新規登録"
        fill_in 'user[name]', with: 'new_user'
        fill_in 'user[email]', with: 'new_user@example.com'
        fill_in 'user[password]', with: '12345678'
        fill_in 'user[password_confirmation]', with: '12345678'
        click_on 'アカウント作成'
        expect(page).to have_content 'new_user'
      end

      it  "管理者はユーザの詳細画面にアクセスできること" do
        visit admin_user_path(id: @user.id)
        expect(page).to have_content "sample"
      end

      it "管理者はユーザの編集画面からユーザを編集できること" do
        visit edit_admin_user_path(id: @user.id)
        fill_in 'user_name', with: 'sample2'
        fill_in 'user_email', with: 'sample2@example.com'
        fill_in 'user_password', with: '00000000'
        fill_in 'user_password_confirmation', with: '00000000'
        click_button '編集完了'
        expect(page).to have_content "sample2"
      end

      it "管理者はユーザの削除をできること" do
        visit admin_users_path
        page.accept_confirm do
          click_on "削除", match: :first
        end
        expect(page).to have_content "ユーザーを削除しました！"
      end
    end
  end
end
