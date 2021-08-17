# require 'rails_helper'

# RSpec.describe Task, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '', content: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: 'リンゴ', content: '' )
        # binding.irb 左記の
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: 'リンゴ', content: 'イチゴ' )
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
    # 必要に応じて、テストデータの内容を変更して構わない
    let!(:task) { FactoryBot.create(:task, title: '味噌ラーメン') } #task
    let!(:second_task) { FactoryBot.create(:second_task, title: "プリンアラモード") } #sample
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        # binding.pry
        # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
        expect(Task.abc('味噌')).to include(task)
        expect(Task.abc('味噌')).not_to include(second_task)
        expect(Task.abc('味噌').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.def('未着手')).to include(task)
        expect(Task.def('着手中')).not_to include(second_task)
        expect(Task.def('未着手').count).to eq 2
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.abc('味噌').def('未着手')).to include(task)
        expect(Task.abc('味噌').def('着手中')).not_to include(second_task)
        expect(Task.abc('味噌').def('未着手').count).to eq 1
      end
    end
  end
end

# わかっていること
# ・Failure/Error: expect(Task.title('task')).to include("味噌")
# NoMethodError:
# undefined method `title' for #<Class:0x0000000006d111a8>
# 上記のエラーから titileなんてものはないと言われている。 
# 果たしてどこから持ってきているのか。。

# expect(Task.abc('task')).to include("味噌")を実行した結果てきにエラーがノーメソッドエラーではなくなった。
# 下記になった。そのためtitleではなく、abcであることが確定した。
# RSpec::Expectations::ExpectationNotMetError: expected #<ActiveRecord::Relation []> to include "味噌"
# from /home/vagrant/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/rspec-support-3.10.2/lib/rspec/support.rb:102:in `block in <module:Support>'
# ArgumentError: wrong number of arguments (given 1, expected 0)
# じょうきは引数の数が₀のはずなのに、１つ与えられてますよ。と言う意味。