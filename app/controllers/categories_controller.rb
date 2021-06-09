class CategoriesController < ApplicationController
    before_action :require_user    
    before_action :set_category, only: [:show,:edit,:update,:destroy]

    def index
        @categories = current_user.categories
    end
    def dashboard
        @active_tab ||= "today"
        @sort_by ||= "due_date"
        @todaytask = current_user.tasks.where('due_date <= ?', DateTime.now.in_time_zone.end_of_day).order(:completed).order(:"#{@sort_by}")
        @todaytask_completed = @todaytask.where(completed:true)
        @todaytask_percent = ((@todaytask_completed.count.to_f / @todaytask.count)*100).round(2)
    

        @alltask = current_user.tasks.order(:completed).order(:"#{@sort_by}")
        @alltask_completed = current_user.tasks.where(completed:true)
        @alltask_percent = ((@alltask_completed.count.to_f / @alltask.count)*100).round(2)
        
    end
    def new
        @category = Category.new
    end
    def create
        @category = Category.new(category_params)
        @category.user = current_user
        
        if @category.save
            flash[:notice] = 'Article was successfull created'
            redirect_to category_path(@category)
        else 
            render 'new'
        end
    end
    def show
        @sort_by ||= "due_date"
    end
    def edit
    end
    def update
        if @category.update(category_params)
            flash[:notice] = 'Category was updated successfully.'
            redirect_to category_path(@category)
        else
            render 'edit'
        end
    end
    def destroy
        @category.destroy
        redirect_to categories_path
    
    end
    private
    def set_category
        categories = current_user.categories
        if categories.find_by_id(params[:id])
            @category = categories.find(params[:id])
        else
            redirect_back fallback_location: categories_path

        end

   end
    def category_params
        params.require(:category).permit(:name,:description,:color)
    end
end

