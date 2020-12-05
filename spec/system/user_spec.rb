require 'rails_helper'
describe 'ユーザー機能', type: :system do
  let!(:user) { FactoryBot.create(:user)}
  let!(:second_user) { FactoryBot.create(:second_user)}
  let!(:admin_user) { FactoryBot.create(:admin_user)}

  describe 'ユーザ登録のテスト' do
    context 'ユーザを新規登録した場合' do
      it 'ユーザーのマイページが表示される' do
        visit new_user_path
        fill_in 'user_name', with: 'aaa'
        fill_in 'user_email', with: 'aaa@example.com'
        fill_in 'user_password', with: 'user_pass'
        fill_in 'user_password_confirmation', with: 'user_pass'
        click_on 'commit'
        expect(page).to have_content 'aaaのページ'
      end
    end

    context 'ユーザがログインせずタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_current_path new_session_path
      end
    end
  end

  describe 'セッション機能のテスト' do
    context 'ログインした場合' do
      it 'マイページに遷移し、ログイン成功の文言が表示される' do
        visit new_session_path
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_on 'commit'
        expect(page).to have_content 'testのページ'
        expect(page). to have_content 'ログインしました'
      end
    end

    context '一般ユーザが他人の詳細画面に飛んだ場合' do
      it 'タスク一覧画面に遷移する' do
        visit new_session_path
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_on 'commit'
        visit user_path(second_user.id)
        expect(page).to have_current_path tasks_path
      end
    end

    context 'ログアウトした場合' do
      it 'ログイン画面に遷移し、ログアウト成功の文言が表示される' do
        visit new_session_path
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_on 'commit'
        click_on 'Logout'
        expect(page).to have_current_path new_session_path
        expect(page).to have_content 'ログアウトしました'
      end
    end

    describe '管理画面のテスト' do
      describe '一般ユーザーとしてのテスト' do
        context '一般ユーザが管理者画面にアクセスした場合' do
          it 'タスク一覧画面に遷移し、アクセスできない旨の文言が表示される' do
            visit new_session_path
            fill_in 'session_email', with: user.email
            fill_in 'session_password', with: user.password
            click_on 'commit'
            visit admin_users_path
            expect(page).to have_current_path tasks_path
            expect(page).to have_content '管理者以外はアクセスできません'
          end
        end
      end

      describe '管理者側のテスト'
        before do
          visit new_session_path
          fill_in 'session_email', with: admin_user.email
          fill_in 'session_password', with: admin_user.password
          click_on 'commit'
        end

        context '管理ユーザが管理画面にアクセスした場合' do
          it 'ユーザ一覧画面が表示される' do
            visit admin_users_path
            expect(page).to have_current_path admin_users_path
            expect(page).to have_content '管理者画面'
          end
        end

        context '管理ユーザがユーザの詳細画面にアクセスした場合' do
          it 'ユーザのタスク一覧画面が表示される' do
            visit admin_user_path(user.id)
            expect(page).to have_content 'タスク名'
          end
        end

        context '管理ユーザがユーザの新規登録をした場合' do
          it 'ユーザ一覧に作成したユーザが表示されること' do
            visit new_admin_user_path
            fill_in 'user_name', with: 'aaa'
            fill_in 'user_email', with: 'aaa@example.com'
            fill_in 'user_password', with: 'user_pass'
            fill_in 'user_password_confirmation', with: 'user_pass'
            select '無', from: '権限'
            click_on 'commit'
            expect(page).to have_content 'aaa'
          end
        end

        context '管理ユーザがユーザの編集画面からユーザを編集した場合' do
          it 'ユーザの編集ができる' do
            visit edit_admin_user_path(user.id)
            fill_in 'user_name', with: 'person'
            fill_in 'user_password', with: user.password
            fill_in 'user_password_confirmation', with: user.password
            click_on 'commit'
            expect(page).to have_content '更新しました'
            expect(page).to have_content 'person'
          end
        end

        context '管理ユーザがユーザを削除した場合' do
          it 'ユーザ一覧に削除したユーザが表示されない' do
            visit admin_users_path
            click_on '削除', match: :first
            page.accept_confirm "本当に削除しますか"
            expect(page).to have_content 'ユーザーを削除しました'
            expect(page).not_to have_content "test"
          end
        end
      end
  end
end
