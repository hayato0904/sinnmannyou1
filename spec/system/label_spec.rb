require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:task, user_id: user.id) }
  let!(:lebel) { FactoryBot.create(:label) }
  let!(:lebel2) { FactoryBot.create(:label2) }
  before do
    visit sessions_new_path
    fill_in 'session[email]', with: 'foo@foo.com'
    fill_in 'session[password]', with: 'foofoo'
    click_on 'Log in'
    visit tasks_path
  end
  describe 'ラベル登録機能' do
    context 'タスクを新規作成時、ラベルを選択した場合' do
      it 'ラベルが登録される' do
        visit new_task_path
       
        click_on '登録する'
        click_on 'Back'
        expect(page).to have_content 'Ruby'
      end
    end

    context 'ラベルを複数登録した場合' do
      it '複数のラベルが登録される' do
        visit new_task_path
      fill_in :task_title, with: 'メロン'
        fill_in :task_content, with: '味噌ラーメン'
        select '2021', from: 'task_expired_at_1i'
        select '10', from: 'task_expired_at_2i'
        select '20', from: 'task_expired_at_3i'
        check 'Ruby'
        check 'Ruby on Rails4'
        click_on '登録する'
        click_on 'Back'
        expect(page).to have_content 'Ruby'
        expect(page).to have_content 'Ruby on Rails4'
      end
    end
  end

  describe 'ラベル編集機能' do
    context 'タスク編集時にラベルの選択を変更した場合' do
      it '変更したラベルに変わる' do
        click_on '編集'
        check 'Ruby'
        check 'Ruby on Rails4'
        click_on '更新する'
        expect(page).to have_content 'Ruby'
        expect(page).to have_content 'Ruby on Rails4'
      end
    end
  end

  describe 'ラベル詳細表示機能' do
    context 'ラベルを登録した場合' do
      it '詳細画面で登録したラベル一覧が表示される' do
        click_on '編集'
        check 'Ruby'
        check 'Ruby on Rails4'
        click_on '更新する'
        click_on 'Back'
        click_on '詳細'
        expect(page).to have_content 'Ruby'
        expect(page).to have_content 'Ruby on Rails4'
      end
    end
  end

  describe 'ラベル検索機能' do
    context '一覧画面でラベルを検索した場合' do
      it '検索に引っかかるタスクが表示される' do
        visit new_task_path
        fill_in :task_title, with: 'メロン'
        fill_in :task_content, with: '味噌ラーメン'
        select '2021', from: 'task_expired_at_1i'
        select '10', from: 'task_expired_at_2i'
        select '20', from: 'task_expired_at_3i'
        check 'Ruby'
        click_on '登録する'
        click_on 'Back'
        select 'Ruby', from: 'label_id'
        click_on 'Search'
        expect(page).to have_content 'Ruby'
      end
    end
  end

end