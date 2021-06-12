class CategoriesController < ApplicationController
    before_action :require_user    
    before_action :set_category, only: [:show,:edit,:update,:destroy]

    def index
        @categories = current_user.categories
    end
    def dashboard
        @active_tab ||= "today"
        @sort_by ||= "due_date"
        if @sort_by == 'category.name'
            @todaytask = current_user.tasks.where('due_date <= ?', DateTime.now.in_time_zone.end_of_day).joins(:category).order('categories.name')
            @alltask = current_user.tasks.order(:completed).joins(:category).order("categories.name")
        else
            @todaytask = current_user.tasks.where('due_date <= ?', DateTime.now.in_time_zone.end_of_day).order(:completed).order(:"#{@sort_by}")
            @alltask = current_user.tasks.order(:completed).order(:"#{@sort_by}")

        end
       
        @todaytask_completed = @todaytask.where(completed:true)
        @todaytask_percent = ((@todaytask_completed.count.to_f / @todaytask.count)*100).round(2)
        todaytask_color_legend = @todaytask.map{|n| n.category.color}.uniq
        todaytask_name_legend = @todaytask.map{|n| n.category.name}.uniq
        @todaytask_legend = []

        todaytask_color_legend.each_with_index do |el,i|
            @todaytask_legend << {:name => todaytask_name_legend[i], :color => el}        
        end
        
        
        @alltask_completed = current_user.tasks.where(completed:true)
        @alltask_percent = ((@alltask_completed.count.to_f / @alltask.count)*100).round(2)
        alltask_color_legend = @alltask.map{|n| n.category.color}.uniq
        alltask_name_legend = @alltask.map{|n| n.category.name}.uniq
        @alltask_legend = []

        alltask_color_legend.each_with_index do |el,i|
            @alltask_legend << {:name => alltask_name_legend[i], :color => el}        
        end
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

