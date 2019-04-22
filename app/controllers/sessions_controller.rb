class SessionsController < ApplicationController
    def new
    end

    def create
        @user = User.find_by_email(params[:email])
        if @user&.authenticate(params[:password])
            flash[:success] = "Logged In"
            session[:user_id] = @user.id
            redirect_to root_path
        else
            flash[:danger] = "Wrong Credentials"
            render :new
        end
    end
    
    def destroy
        session[:user_id] = nil
        flash[:success] = "Logged out!"
        redirect_to root_path
    end

end
