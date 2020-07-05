class Admin::UsersController < ApplicationController
  before_action :set_admin, only: [:update, :show, :edit, :destroy]
  before_action :check_admin
  PER = 8

  def index
    @users = User.all.order(created_at: :DESC).page(params[:page]).per(PER)
  end

  def show
    @tasks = @user.tasks.page(params[:page]).per(5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice:"#{@user.name}を登録しました!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "編集しました！"
    else
      render :show
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice:"ユーザーを削除しました！"
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :admin)
    end

    def set_admin
      @user = User.find(params[:id])
    end

    def check_admin
      unless current_user.admin == true
        redirect_to tasks_path, notice: "あなたは管理者ではありません"
      end
    end

  end
