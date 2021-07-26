class UsersController < ApplicationController
    def new
        if logged_in?
            redirect_to dashboard_path
        end
        @user = User.new
    end
    def index
        redirect_to signup_path
    end
    def create
        @user = User.new(user_params)
        if@user.save
            session[:user_id] = @user.id
            flash[:notice]="Welcome to the Everyday #{@user.username}, you have successfully sign up"
            redirect_to dashboard_path
        else
            render 'new'
        end

    end
    private
    def set_user
        @user = User.find(params[:id])
    end
    def user_params
        params.require(:user).permit(:firstname,:lastname, :username, :email, :password, :password_confirmation)
    end
end
