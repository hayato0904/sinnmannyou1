class Task < ApplicationRecord
        validates :title, presence: true
        validates :content, presence: true
        enum status: {未着手:0, 着手中:1, 完了:2}
        enum priority: {高:0, 中:1, 低:2}
        scope :abc, ->(params_title) { where('title LIKE ?', "%#{params_title}%")}
        scope :def, ->(params_status) { where(status: params_status)}
        belongs_to ;user

        # @tasks = @tasks.where(status: params[:status]) if params[:status] && params[:status] != ""

        # abcを定義した。引数はparams.
        # (params)仮引数は定義するものが仮に用意しておくもの。
        # 実引数はそのメソッドが使う側が使う引数のこと。
        # abcメソッドが使うのがコントローラー側。
        

        # scope :status_search, ->(params) { where(status: params) }
end
# やること
# ・scopeメソッドでステータス検索ができる
# ・scopeメソッドでタイトルとステータスの両方が検索できる
# わかったこと。
# ・paramsを受け取る
# ・
# わからないところ。
# ・