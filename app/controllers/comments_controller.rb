class CommentsController < ApplicationController
    def create
        byebug
        @category = Category.find(params[:category_id])
        @task = Task.find(params[:task_id])
        byebug
        @comment = @task.comments.build(comment_params)
        byebug
        if @comment.save
            flash[:notice] = 'Tasks was successfully created'
            redirect_to category_task_path(@category,@task)

        else
            redirect_to category_task_path(@category,@task)
        end
    end
    def comment_params
        params.require(:comment).permit(:body)
    end
end
