class TasksController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_task, only: %i[ show edit update destroy ]

  
  # わかったこと
  # ・scopeとは、クラスメソッドを使う際、可読性を保つためにあるもの
  # ・書き方(Qiita見ながら)
  # ・viewから値を取ってくる　→ コントローラに渡す → コントローラ側で、scopeで使える形に変換→scopeに渡す
  # わからないところ。
  # ・viewから値をとってくる。とQiitaに記載されていたが、どうやって！どのようにして！
  # ・モデルを使うイメージがあったが。。。
  def index
    @tasks = current_user.tasks.order(created_at: :desc)
    @tasks = @tasks.reorder(expired_at: :desc) if params[:sort_expired]
    # @tasks = @tasks.search_title(params[:title]).search_status(params[:status]) if params[:title].present? && params[:status].present?
    @tasks = @tasks.search_title(params[:title]) if params[:title].present?
    @tasks = @tasks.search_status(params[:status]) if params[:status].present?
    @tasks = @tasks.reorder(priority: :asc) if params[:sort_priority]
    @tasks = @tasks.search_label(params[:label_id]) if params[:label_id].present?
    # @tasks = @tasks.joins(:labels).where(labels: { id: params[:label_id] }) if params[:label_id].present?
    @tasks = @tasks.page(params[:page]).per(6)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.build(task_params) #current_user.blogs.build は「ログイン中のユーザの、blogをbuild(new)する」という意味です。
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :content, :expired_at, :status, :task, :priority, { label_ids: [] })
      # □なぜタスクを追加したんだろう？
    end
  end