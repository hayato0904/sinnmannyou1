class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  
  # わかったこと
  # ・scopeとは、クラスメソッドを使う際、可読性を保つためにあるもの
  # ・書き方(Qiita見ながら)
  # ・viewから値を取ってくる　→ コントローラに渡す → コントローラ側で、scopeで使える形に変換　→ 　scopeに渡す
  # わからないところ。
  # ・viewから値をとってくる。とQiitaに記載されていたが、どうやって！どのようにして！
  # ・モデルを使うイメージがあったが。。。



  def index
    @tasks = Task.all
    # 上記はkaminariである。
    @tasks = @tasks.order(expired_at: "ASC") if params[:sort_expired]
    @tasks = @tasks.order(priority: "ASC") if params[:sort_priority]
    @tasks = @tasks.abc(params[:title]).def(params[:status]) if params[:title].present? && params[:status].present?
    @tasks = @tasks.abc(params[:title]) if params[:title].present?
    @tasks = @tasks.def(params[:status]) if params[:status].present?
    @tasks = @tasks.page(params[:page]).per(6)

    # 18行目の続き    .present? && params[:status] != ""
    # 21行目の続き && params[:status] != ""
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit


    
  end

  def create
    @task = Task.new(task_params)

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
      params.require(:task).permit(:title, :content, :expired_at, :status, :task, :priority)
      # □なぜタスクを追加したんだろう？
    end
  end