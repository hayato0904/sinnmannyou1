require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:second_task, title: '付け加えた名前３', content: '付け加えたコンテント', expired_at: '2021-08-1')
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # テストで使用するためのタスクを作成
        task = FactoryBot.create(:task)
        # タスク一覧ページに遷移
        visit tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content 'ごはんをたべる'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end

    # テスト内容を追加で記載する
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task1 = FactoryBot.create(:task)
        # task2 = FactoryBot.create(:task, title: 'task2')
        visit tasks_path
        task3 = all('.task_row')
        # binding.pry
        expect(task3[0]).to have_content 'ごはんをたべる' 
        expect(task3[1]).to have_content '付け加えた名前３' 
        expect(task3[2]).to have_content 'Factoryで作ったデフォルトのタイトル２' 
        expect(task3[3]).to have_content 'ごはんをたべる' 
      end
    end
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in :task_title, with: 'メロン'
        fill_in :task_content, with: '味噌ラーメン'
        select '2021', from: 'task[expired_at(1i)]'
        select '10月', from: 'task[expired_at(2i)]'
        select '20', from: 'task[expired_at(3i)]'
        click_on "登録する"
        expect(page).to have_content "メロン" # タスク詳細画面に"メロン"の文字列があることを証明する
        click_on "Back"
        expect(page).to have_content "メロン" # タスク一覧画面にメロンと味噌ラーメンの文字列が含まれていることを証明する
        expect(page).to have_content "味噌ラーメン"
        expect(page).to have_content "2021-10-20"
      end
    end
  end

  describe '終了期限のカラム追加機能' do
    context '日時を入力した場合' do
      it '日時が表示される' do
        visit new_task_path
        fill_in :task_title, with: 'メロン'
        fill_in :task_content, with: '味噌ラーメン'
        select '2021', from: 'task[expired_at(1i)]'
        select '10月', from: 'task[expired_at(2i)]'
        select '20', from: 'task[expired_at(3i)]'
        click_on "登録する"
        expect(page).to have_content "2021-10-20" # タスク詳細画面に"2021-06-20"の文字列があることを証明する
      end
    end
  end

  describe '終了期限ソート機能' do
    context '終了期限でソートするというリンクを押すと' do
      it '終了期限の降順に並び替えられたタスク一覧が表示される' do
        visit tasks_path
        click_on '終了期限でソートする' 
        # , match: :first
        task4 = all('.task_row')
        expect(task4[0]).to have_content '2021-07-28'
        expect(task4[1]).to have_content '2021-07-30'
      end
    end
  end


  

end



