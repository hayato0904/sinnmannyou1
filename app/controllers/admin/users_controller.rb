class Admin::UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  # 上記ArgumentErrorが発生した。
  # login?required が定義されていないとケラー分が出ている。
  # 仮説：login_requiredが存在しているかを確認すべきである。
  # そもそも skip_before_actionの定義をちゃんと理解すべきである。
  # また記載する場所の確認も必要だ。
    def index
      @users = User.all.page(params[:page]).per(6)
    end

    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to admin_users_path
        # _pathっているっけ？ 後で確認しなくきゃ
      else
        render :new
      end
    end
  
    def show
      @user = User.find(params[:id])
    end

    def edit
      @user = User.find(params[:id])
      # NoMethodError in Admin::Users#edit
      # editの内容を削除すると、上記のエラーが生じてしまうのでだめだ。でもtaskはなんでeditの中身がないのに編集できるんだ？
    end

    def update
      # そもそもなんでbinding.pryで止まらないんだ。
      # 処理が来てない？ いやでも、
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to admin_users_path
      else
        render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice:"ブログを削除しました！"
  end
  
      def user_params
        params.require(:user).permit(:name, :email, :password,
          :password_confirmation)
        end
  end
  