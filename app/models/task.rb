class Task < ApplicationRecord
        validates :title, presence: true
        validates :content, presence: true
        enum status: {未着手:0, 着手中:1, 完了:2}
        enum priority: {高:0, 中:1, 低:2}
        scope :search_title, -> (params_title) { where('title LIKE ?', "%#{params_title}%")}
        scope :search_status, -> (params_status) { where(status: params_status)}
        scope :search_label, -> (params_label) {
                task_ids = Labelling.where(label_id: params_label).pluck(.label_id)
                where(id: task_ids)
        }
        belongs_to :user 
        has_many :labellings, dependent: :destroy
        has_many :labels, through: :labellings
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