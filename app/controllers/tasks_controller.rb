class TasksController < ApplicationController
    before_action :get_category
    before_action :require_user
    before_action :require_same_user, only: [:show, :edit, :update, :destroy, :index, :new] 
    before_action :set_task, only: [:show,:edit,:update,:destroy]

    def index
        @tasks = @category.tasks
        
    end
    def new
        @task = @category.tasks.build
    end
    def create
        @task = @category.tasks.build(task_params)
        @task.user = current_user
        
        if @task.save
            flash[:notice] = 'Tasks was successfully created'
            redirect_to category_task_path(id:@task)
        else
            render 'new'
        end
    end
    def show
        byebug
    end
    private
    
    def get_category
        @category = Category.find(params[:category_id])
    end
    def set_task
        @task = Task.find(params[:id])
    end
    def task_params
        params.require(:task).permit(:name,:description,:category_id,:user_id,:due_date)
    end
end
