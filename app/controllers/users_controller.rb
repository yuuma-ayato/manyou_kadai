class UsersController < ApplicationController
  before_action :set_user, only: [:update, :show, :edit]
  before_action :check_logout, only: [:new]

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to user_path(@user.id)
      else
        render :new
      end
    end

    def edit
    end

    def update
    end

    def show
      unless @user == current_user
        redirect_to tasks_path, notice: '他の人のページへアクセス出来ません'
      end
    end


    private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :admin)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def check_logout
      if logged_in?
        redirect_to tasks_path, notice:"ログイン中です"
      end
    end

  end
