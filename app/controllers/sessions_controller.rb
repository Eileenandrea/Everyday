class SessionsController < ApplicationController
    def new
    end
    def create
        users = User.all
        user = User.find_by(email: params[:session][:email])
        
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash[:notice] = 'Logged in successfully'
            redirect_to dashboard_path
        else
            flash.now[:alert] = 'Wrong Email or Password'
            render 'new'
        end
        
    end
    def destroy
    end
end
