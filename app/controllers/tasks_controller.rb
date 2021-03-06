class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  PER = 6

  def index
    if params[:sort_expired]
      @tasks = current_user.tasks.order(limit: :ASC).page(params[:page]).per(PER)
    elsif params[:sort_priority]
      @tasks = current_user.tasks.order(priority: :ASC).page(params[:page]).per(PER)
    else
      @tasks = current_user.tasks.order(created_at: :DESC).page(params[:page]).per(PER)
    end

    if params[:search].present?
      if params[:title].present? && params[:status].present?#渡されたパラメータがタイトルとステータス両方だった場合
        @tasks = @tasks.title_search(params[:title]).status_search(params[:status]).page(params[:page]).per(PER)
      elsif params[:title].present?#渡されたパラメータがタイトルのみだった場合
        @tasks = @tasks.title_search(params[:title]).page(params[:page]).per(PER)
      elsif params[:status].present?#渡されたパラメータがステータスのみだった場合
        @tasks = @tasks.status_search(params[:status]).page(params[:page]).per(PER)
      end
    end

     @tasks = @tasks.joins(:labels).where(labels: { id: params[:label_id] }) if params[:label_id].present?

  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice: "タスクを作成しました！"
      else
        render :new
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "ブログを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"ブログを削除しました！"
  end

  def confirm
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    render :new if @task.invalid?
  end


  private
  def task_params
    params.require(:task).permit(:title, :content, :limit, :status, :priority, { label_ids: [] })
  end

  def check_login
    unless logged_in?
      flash[:notice] = "ログインしてください"
      redirect_to new_session_path
    end
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
