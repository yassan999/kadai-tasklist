class TasksController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      @task = current_user.tasks.build  # form_for 用
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'タスクを追加しました。'
      redirect_to root_url
    else
      flash[:danger] = 'タスクが追加されませんでした。'
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = 'タスクが変更されました。'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが変更できませんでした。'
      render :new
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = 'タスクを削除しました。'
    redirect_to @task
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
end
