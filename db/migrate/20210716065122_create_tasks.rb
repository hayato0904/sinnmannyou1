class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :content
      t.date :expired_at
      t.timestamps
    end
  end
  # add_index :tasks, [:title, :content] 
end



# t.expired_at :date
# 上記のコードだdownになったマイグレーションファイルがupにならない。
# Why: 
# テキストにnot_nullで中身を追加しないといけないと記載されている。
# What：not_nullに中身を追加すれば問題は解決する。
# How：全く分からん。

# 下記一行は学習日記から拾ってきたnot_nullの使いかた記入の方法がちがう。さんこうにならん。
# change_column_null :properties, :rent, null: false

