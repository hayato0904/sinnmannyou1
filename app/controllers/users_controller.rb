class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :signup_not, only: [:new, :create]
  # 上記ArgumentErrorが発生した。
  # login?required が定義されていないとケラー分が出ている。
  # 仮説：login_requiredが存在しているかを確認すべきである。
  # そもそも skip_before_actionの定義をちゃんと理解すべきである。
  # また記載する場所の確認も必要だ。
  def new
    @user = User.new

  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
      # _pathっているっけ？ 後で確認しなくきゃ
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks
  end
      private
    def user_params
      params.require(:user).permit(:name, :email, :password,
        :password_confirmation, :admin)
      end
 
      def signup_not
        redirect_to tasks_path if current_user
      end

end
