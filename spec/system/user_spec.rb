# require 'rails_helper'
# RSpec.describe 'ユーザー機能', type: :system do
#   let!(:user) { FactoryBot.create(:user) }
#   let!(:user2) { FactoryBot.create(:user2) }
#   let!(:user3) { FactoryBot.create(:user3) }
#   before do
#     visit sessions_new_path
#   end
#   describe 'ユーザー新規作成機能' do
#     context 'ユーザー新規作成した場合' do
#       it 'ユーザー新規登録できる' do
#         visit new_user_path
#         fill_in 'user[name]', with: 'test'
#         fill_in 'user[email]', with: 'test@test.com'
#         fill_in 'user[password]', with: 'testtest'
#         fill_in 'user[password_confirmation]', with: 'testtest'
#         click_on '登録'
#         expect(page).to have_content 'test'
#         expect(page).to have_content 'test@test.com'
#       end
#     end
#     context 'ユーザーがログインせずタスク一覧画面に飛ぼうとした場合' do
#       it 'ログイン画面に遷移' do
#         visit tasks_path
#         expect(page).to have_content 'ログイン画面'
#       end
#     end
#   end
#   describe 'セッション機能' do
#     context 'ログイン操作した場合' do
#       it 'ログインできる' do
#         visit sessions_new_path
#         fill_in 'session[email]', with: 'foo@foo.com'
#         fill_in 'session[password]', with: 'foofoo'
#         click_on 'ログインする'
#         expect(page).to have_content 'foo@foo.com'
#       end
#     end
#     context '詳細ボタンを押した場合' do
#       it '自分の詳細画面に飛べる' do
#         visit sessions_new_path
#         fill_in 'session[email]', with: 'foo@foo.com'
#         fill_in 'session[password]', with: 'foofoo'
#         click_on 'ログインする'
#         click_on 'タスク管理へ'
#         click_on 'マイページ'
#         expect(page).to have_content 'foo@foo.com'
#       end
#     end
#     context '一般ユーザーが他人の詳細画面に飛ぶ場合' do
#       it 'タスク一覧画面に遷移' do
#         visit sessions_new_path
#         fill_in 'session[email]', with: 'bar@bar.com'
#         fill_in 'session[password]', with: 'barbar'
#         click_on 'ログインする'
#         visit user_path(user)
#         expect(page).to have_content 'タスク一覧画面'
#       end
#     end
#     context 'ログアウトボタン操作した場合' do
#       it 'ログアウトできる' do
#         visit sessions_new_path
#         fill_in 'session[email]', with: 'bar@bar.com'
#         fill_in 'session[password]', with: 'barbar'
#         click_on 'ログインする'
#         click_on 'ログアウト'
#         expect(page).to have_content 'ログアウトしました'
#       end
#     end
#   end
#   describe '管理画面機能' do
#     context '管理ユーザーは管理画面遷移操作した場合' do
#       it '管理画面にアクセスできる' do
#         visit sessions_new_path
#         fill_in 'session[email]', with: 'foo@foo.com'
#         fill_in 'session[password]', with: 'foofoo'
#         click_on 'ログインする'
#         click_on '管理画面'
#         expect(page).to have_content '管理画面：ユーザー一覧'
#       end
#     end
#     context '一般ユーザーが管理画面遷移操作した場合' do
#       it '管理画面にアクセスできない' do
#         visit sessions_new_path
#         fill_in 'session[email]', with: 'bar@bar.com'
#         fill_in 'session[password]', with: 'barbar'
#         click_on 'ログインする'
#         click_on '管理画面'
#         expect(page).to have_no_content '管理画面：ユーザー一覧'
#       end
#     end
#     context '管理ユーザは管理画面でユーザーの新規登録操作した場合' do
#       it 'ユーザー新規登録できる' do
#         visit sessions_new_path
#         fill_in 'session[email]', with: 'foo@foo.com'
#         fill_in 'session[password]', with: 'foofoo'
#         click_on 'ログインする'
#         click_on '管理画面'
#         click_on '新規登録'
#         fill_in 'user[name]', with: 'test'
#         fill_in 'user[email]', with: 'test@test.com'
#         fill_in 'user[password]', with: 'testtest'
#         fill_in 'user[password_confirmation]', with: 'testtest'
#         click_on '登録'
#         expect(page).to have_content 'test'
#       end
#     end
#     context '管理ユーザーは一般ユーザーの詳細画面遷移操作した場合' do
#       it 'ユーザー詳細画面にアクセスできる' do
#         visit sessions_new_path
#         fill_in 'session[email]', with: 'foo@foo.com'
#         fill_in 'session[password]', with: 'foofoo'
#         click_on 'ログインする'
#         visit user_path(user2)
#         expect(page).to have_content 'bar@bar.com'
#       end
#     end
#     context '管理ユーザーは管理画面でユーザー編集操作した場合' do
#       it 'ユーザーの編集ができる' do
#         visit sessions_new_path
#         fill_in 'session[email]', with: 'foo@foo.com'
#         fill_in 'session[password]', with: 'foofoo'
#         click_on 'ログインする'
#         click_on '管理画面'
#         click_link '編集', href: edit_admin_user_path(user2)
#         fill_in 'user[name]', with: 'barr'
#         fill_in 'user[password]', with: 'barbar'
#         fill_in 'user[password_confirmation]', with: 'barbar'
#         click_on '更新'
#         expect(page).to have_content 'barr'
#       end
#     end
#     context '管理ユーザーは管理画面でユーザー削除操作した場合' do
#       it 'ユーザー削除できる' do
#         visit sessions_new_path
#         fill_in 'session[email]', with: 'foo@foo.com'
#         fill_in 'session[password]', with: 'foofoo'
#         click_on 'ログインする'
#         click_on '管理画面'
#         click_link '削除', href: admin_user_path(user2)
#         expect {
#           page.accept_confirm '削除しますか？'
#           expect(page).to have_content 'bar'
#         }
#       end
#     end
#   end
# end