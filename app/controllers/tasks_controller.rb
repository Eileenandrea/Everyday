class TasksController < ApplicationController
    before_action :set_task, only: [:show,:edit,:update,:destroy]
    before_action :check_id, only: [:show,:edit,:update,:destroy]
    before_action :get_category
    before_action :require_user
    before_action :require_same_user, only: [:show, :edit, :update, :destroy, :index, :new] 

    def index
        @tasks = @category.tasks
    
    end
    def new
        @task = @category.tasks.build
    end
    def create
        @task = @category.tasks.build(task_params)
        
        if @task.save
            flash[:notice] = 'Tasks was successfully created'
            redirect_to category_path(@category)
        else
            render 'new'
        end
    end
    def show
    end
    def edit
    end
    def update
        if @task.update(task_params)
            flash[:notice] = 'Task was updated successfully.'
            redirect_to category_task_path(id:@task)
        else
            render 'edit'
        end
    end
    def destroy
        @task.destroy
        redirect_to category_tasks_path(Category.last)
    end


    private
    
    def get_category
        @category = Category.find(params[:category_id])
    end
    def set_task
        @task = Task.find(params[:id])
    end
    def task_params
        params.require(:task).permit(:name,:description,:category_id,:due_date,:completed,:completed_at)
    end
    def check_id
        if params[:category_id].to_i != @task.category_id
            flash[:alert] = "Invalid URL"
            redirect_to dashboard_path
        end
    end
end
