FactoryBot.define do
  factory :task do
    
    title { 'ごはんをたべる' }
    content { '味噌汁をのむ' }
    expired_at {'2021-07-30'}
  end
  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル２' }
    content { 'Factoryで作ったデフォルトのコンテント２' }
    expired_at {'2021-07-28'}

  end
end
